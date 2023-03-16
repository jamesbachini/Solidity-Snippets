// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Variables {
    uint256 public myUint;
    int256 public myInt;
    bool public myBool;
    address public myAddress;
    bytes32 public myBytes32;
    string public myString;
    uint256[] public myArray;

    enum State { INACTIVE, ACTIVE }
    State public myState = State.INACTIVE;

    struct Person {
        string name;
        uint256 age;
    }
    Person public myPerson;

    constructor() {
        myUint = 123;
        myInt = -456;
        myBool = true;
        myAddress = msg.sender;
        myBytes32 = 0x0;
        myString = "Hello, world!";
        myArray = [1, 2, 3, 4, 5];
        myPerson = Person("Alice", 30);
    }

    function setUint(uint256 newValue) public {
        myUint = newValue;
    }

    function setPerson(string memory name, uint256 age) public {
        myPerson = Person(name, age);
    }

    function addToArray(uint256 newValue) public {
        myArray.push(newValue);
    }
}