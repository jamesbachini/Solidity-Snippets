// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Events  {
    event LogThis(string msg);

    function test() external {
        emit LogThis('Hello World');
    }
}
