// SPDX-License-Identifier: MIT
pragma solidity >=0.8.11;

interface IERC20 {
    function transfer(address recipient, uint amount) external returns (bool);
}

contract encodeCall {
    function encodeCallData(address _to, uint _value) public pure returns (bytes memory) {
        return abi.encodeCall(IERC20.transfer, (_to, _value));
    }
}