// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// Struct Structure Example
contract Structural {
    struct Newb {
        string name;
        uint age;
        address addy;
    }
    Newb[] public newbies; // an array

    mapping (address => Newb) public newbs; // a mapping

    function addMe public () {
        newbies.push(Newb('James',21,msg.sender);
    }

    function whatsMyAgeAgain public view returns(uint) {
        return newbies[0].age;
    }
}
