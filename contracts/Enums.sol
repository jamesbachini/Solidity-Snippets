// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Enums {
    enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

    function getNextDay(Day _currentDay) public pure returns (Day) {
        if (_currentDay == Day.Sunday) return Day.Monday;
        return Day(uint(_currentDay) + 1);
    }
}
