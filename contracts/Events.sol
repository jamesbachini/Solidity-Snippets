// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Events  {
  event logThis(string msg);

  function test() external {
    emit logThis('Hello World');
  }
}
