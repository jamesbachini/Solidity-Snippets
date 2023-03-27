// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleDemo {
  address public test;
  bytes32 public merkleRoot;

  constructor(bytes32 _merkleRoot) {
    merkleRoot = _merkleRoot;
  }

  function claim(bytes32[] memory _proof, address _account) public {
    bytes32 leaf = keccak256(abi.encodePacked(_account));
    require(MerkleProof.verify(_proof, merkleRoot, leaf), "Invalid proof");
    test = _account; // whitelisted addresses can access this logic
  }
}