// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

// Generate a random enough number for most applications
contract RandomishNumbers {

    function random() private view returns (uint) {
        uint hashNumber =  uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        return hashNumber % 100;
    }
}

// For more secure randomness consider an off-chain oracle service such as https://docs.chain.link/docs/chainlink-vrf/
