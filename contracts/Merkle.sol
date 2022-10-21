// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// https://github.com/dragonfly-xyz/useful-solidity-patterns/

contract Merkle {
  bytes32 public immutable MerkleRoot;
  mapping (address => bool) public hasClaimed;

  constructor(bytes32 _root) payable {
    MerkleRoot = _root;
  }

  function prove(bytes32 leaf, bytes32[] memory _siblings) public view returns (bool) {
    require(leaf != 0, 'invalid leaf value');
    bytes32 node = leaf;
    for (uint256 i = 0; i < _siblings.length; ++i) {
      bytes32 sibling = _siblings[i];
      node = keccak256(node > sibling ? abi.encode(sibling, node) : abi.encode(node, sibling));
    }
    return node == MerkleRoot;
  }

  function claim(address payable member, uint256 _claimAmount, bytes32[] memory _proof) external {
    require(prove(~keccak256(abi.encode(member, _claimAmount)), _proof), 'bad proof');
    hasClaimed[member] = true;
    member.transfer(_claimAmount);
  }
}

contract MerkleHelper {
  function constructTree(address[] memory _members, uint256[] memory _claimAmounts) external pure returns (bytes32 root, bytes32[][] memory tree) {
    require(_members.length != 0 && _members.length == _claimAmounts.length);
    uint256 height = 0;
    {
      uint256 n = _members.length;
      while (n != 0) {
        n = n == 1 ? 0 : (n + 1) / 2;
        ++height;
      }
    }
    tree = new bytes32[][](height);
    bytes32[] memory nodes = tree[0] = new bytes32[](_members.length);
    for (uint256 i = 0; i < _members.length; ++i) {
      nodes[i] = ~keccak256(abi.encode(_members[i], _claimAmounts[i]));
    }
    for (uint256 h = 1; h < height; ++h) {
      uint256 nHashes = (nodes.length + 1) / 2;
      bytes32[] memory hashes = new bytes32[](nHashes);
      for (uint256 i = 0; i < nodes.length; i += 2) {
        bytes32 a = nodes[i];
        bytes32 b = i + 1 < nodes.length ? nodes[i + 1] : bytes32(0);
        hashes[i / 2] = keccak256(a > b ? abi.encode(b, a) : abi.encode(a, b));
      }
      tree[h] = nodes = hashes;
    }
    root = tree[height - 1][0];
  }

  function createProof(uint256 _memberIndex, bytes32[][] memory _tree) external pure returns (bytes32[] memory _proof) {
    uint256 leafIndex = _memberIndex;
    uint256 height = _tree.length;
    _proof = new bytes32[](height - 1);
    for (uint256 h = 0; h < _proof.length; ++h) {
      uint256 siblingIndex = leafIndex % 2 == 0 ? leafIndex + 1 : leafIndex - 1;
      if (siblingIndex < _tree[h].length) {
        _proof[h] = _tree[h][siblingIndex];
      }
      leafIndex /= 2;
    }
  }
}
