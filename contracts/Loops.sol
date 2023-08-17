// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Loops {
    uint[20] public values;
    
    function replaceValue(uint _breakPoint) public {
        for (uint i = 0; i < values.length; i++) {
            if (i == 5) {
                continue; // skip to next i
            } else if (i >= _breakPoint) {
                break; // break out of loop
            } else {
                values[i] = i;
            }
        }
    }

    function automate() external {
        uint x = 10;
        while (values[12] == 0) {
            replaceValue(x);
            x ++;
        }
    }

    function uglyAutomate() external {
        uint x = 10;
        do {
            replaceValue(x);
            x ++;
        } while (values[12] == 0);
    }
      
}