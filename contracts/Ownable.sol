// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

// Ownable Contracts Using Open Zeppelin Library
import "@openzeppelin/contracts//contracts/access/Ownable.sol";

contract OwnableExample1 is Ownable {

  function adminFunctionExample() public onlyOwner {
    // Avoid Decentralisation Here
  }
}

// Ownable Contracts Using Modifier
contract OwnableExample2 {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "not owner");
    _;
  }

  function setOwner(address _newOwner) public onlyOwner {
    owner = _newOwner;
  }
  
  function adminFunctionExample() public onlyOwner {
    // Avoid Decentralisation Here
  }
}