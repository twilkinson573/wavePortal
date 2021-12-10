// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract WavePortal {
	uint256 totalWaves;
	address[] waveAddresses;

	mapping (address => uint) waveCounts;

  constructor() {
  	console.log("whaddup tho");
  }

  function wave() public {
  	totalWaves += 1;

  	if (waveCounts[msg.sender] == 0) {
  		waveAddresses.push(msg.sender);
  	}

  	waveCounts[msg.sender]++;

  	console.log("%s has waved bruh!", msg.sender);
  }

  function getTotalWaves() public view returns (uint256) {
  	console.log("We have %d total waves", totalWaves);
  	return totalWaves;
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
