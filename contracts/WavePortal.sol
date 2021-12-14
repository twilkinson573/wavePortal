// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract WavePortal {

	uint256 totalWaves;
	address[] waveAddresses;
	Wave[] waves;

	mapping (address => uint) waveCounts;

  struct Wave {
  	address waver;
  	string message;
  	uint256 timestamp;
  }

  // Event NewWave

  event NewWave(address indexed waver, string message, uint256 timestamp);

  constructor() {
  	console.log("whaddup tho");
  }

  function wave(string memory _message) public {
  	totalWaves += 1;

  	waves.push(Wave(msg.sender, _message, block.timestamp));

  	emit NewWave(msg.sender, _message, block.timestamp);

  	if (waveCounts[msg.sender] == 0) {
  		waveAddresses.push(msg.sender);
  	}

  	waveCounts[msg.sender]++;

  	console.log("%s has waved saying %s, bruh!", msg.sender, _message);
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
