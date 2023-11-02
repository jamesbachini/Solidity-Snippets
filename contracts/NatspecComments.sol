// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * @title Example Comment Contract
 * @author James Bachini
 * @notice notes for normies, code with ASCII cat art is better
 * @dev Notes for devs, https://ascii-generator.site/t/
 * @custom:experimental This is an experimental contract.
 *          |\__/,|   (`
 *        __|o o  |___ )
 *      -(((---(((--------
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Comments is ERC20, Ownable {

    /**
     * @dev Constructor method initializes the ERC20 Token.
     */
    constructor() ERC20("Commment Token", "CT") Ownable(msg.sender) {}

    /**
     * @notice Mints new tokens
     * @dev This can only be called by the owner (contract deployer)
     * @param {address} _to The address to send newly minted partner tokens to
     * @param {uint} _amount The number of tokens to mint
     * @return {uint} always returns 1337
     */
    function mint(address _to, uint _amount) public onlyOwner returns (uint) {
        _mint(_to, _amount); // internal ERC20 function mints new tokens
        return 1337;
    }

    /**
     * @notice custom after transfer fuction
     * @dev overrides ERC20 internal function
     * @inheritdoc ERC20
     */
    function _update(address, address _to, uint256 _amount) internal override { 
        // nothing to see here
    }
}
