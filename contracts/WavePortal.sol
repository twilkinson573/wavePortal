// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract WavePortal {

	// State vars =========================================================

	uint256 totalWaves;
	address[] waveAddresses;
	Wave[] waves;

	mapping (address => uint) waveCounts;

  struct Wave {
  	address waver;
  	string message;
  	uint256 timestamp;
  }

	// Events =============================================================

  event NewWave(address indexed waver, string message, uint256 timestamp);

	// Functions ==========================================================

  constructor() payable {
  	console.log("whaddup tho");
  }

  function wave(string memory _message) public {
  	totalWaves += 1;

  	waves.push(Wave(msg.sender, _message, block.timestamp));

  	emit NewWave(msg.sender, _message, block.timestamp);

  	// Record wave
  	if (waveCounts[msg.sender] == 0) {
  		waveAddresses.push(msg.sender);
  	}
  	waveCounts[msg.sender]++;

  	console.log("%s has waved saying %s, bruh!", msg.sender, _message);

  	// Award the prize
  	uint256 prizeAmount = 0.0001 ether;
    require(prizeAmount <= address(this).balance, "Insufficient balance for prize");

    (bool success, ) = (msg.sender).call{value: prizeAmount}("");
    require(success, "Failed to withdraw money from contract.");
    console.log("Prize awarded: new balance:");
    console.log(address(this).balance);
  }

  function getTotalWaves() public view returns (uint256) {
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
