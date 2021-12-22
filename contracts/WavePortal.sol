// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract WavePortal {

	// State vars =========================================================

	uint private seed;
	uint totalWaves;
	address[] waveAddresses;
	Wave[] waves;

	mapping (address => uint) waveCounts;
	mapping (address => uint) lastWavedAt;

  struct Wave {
  	address waver;
  	string message;
  	uint timestamp;
  }

	// Events =============================================================

  event NewWave(address indexed waver, string message, uint timestamp);

	// Functions ==========================================================

  constructor() payable {
  	console.log("whaddup tho");
  	// Set the initial pseudo-random seed
  	seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
  	require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Must wait 15 minutes between waves");

  	waves.push(Wave(msg.sender, _message, block.timestamp));
  	console.log("%s has waved saying %s, bruh!", msg.sender, _message);

  	emit NewWave(msg.sender, _message, block.timestamp);

  	// Update state records
  	if (waveCounts[msg.sender] == 0) { waveAddresses.push(msg.sender); }
  	totalWaves += 1;
  	waveCounts[msg.sender]++;
  	lastWavedAt[msg.sender] = block.timestamp;

	
	  // Create random seed to award prize
	  seed = (block.timestamp + block.difficulty + seed) % 100;
	  console.log("Random number generated: %d", seed);

	  if (seed <= 50) {
	  	// Award the prize
	  	uint prizeAmount = 0.0001 ether;
	    require(prizeAmount <= address(this).balance, "Insufficient balance for prize");

	    (bool success, ) = (msg.sender).call{value: prizeAmount}("");
	    require(success, "Failed to withdraw money from contract.");
	    console.log("Prize awarded: new balance: %d", address(this).balance);
	  } else {
	  	console.log("No prize awarded");
	  }
  }

  function getTotalWaves() public view returns (uint) {
  	console.log("We have %d total waves", totalWaves);
  	return totalWaves;
  }

  function getAllWaves() public view returns (Wave[] memory) {
  	return waves;
  }

  function listWaveAddresses() external view {
  	console.log("--------------------------");
  	console.log("Wavers:");
    for(uint i = 0; i < waveAddresses.length; i++) {
    	console.log("%s: %s", waveAddresses[i], waveCounts[waveAddresses[i]]);
    }
  	console.log("--------------------------");
  }
  
}
