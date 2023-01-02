// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract PassFunction {
    uint public n;

    function exec(uint _a) internal pure returns (uint) {
        return _a * 2;
    }

    function run(function(uint) internal returns (uint) _func, uint _x) internal {
        n = _func(_x);
    }

    function test() external {
        run(exec,8);
    }

}