// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/**
 * @title Natspec
 * @author James Bachini
 * @dev An example contract to demonstrate natspec documentation
 * @notice This contract is untested
 * @custom:experimental This is an experimental contract.
 */
contract Natspec {
    string public txt = "I hate code comments";

    /**
     * @dev Update the txt state variable
     * @notice This returns a uint for no reason
     * @param {string} _txt a new text string
     * @return {uint} just a demo number
     */
    function update(string memory _txt) public returns (uint) {
        txt = _txt;
        return 1;
    }
}