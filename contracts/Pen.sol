// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/*    ____    __ _  __  ___    ______ _         ___            _
 *   / __/__ / / / /  |/  /__ /_  __/ / ( )__  / _ \___ __    | |
 *  _\ \/ -_/ / / / /|_/ / -_/ / / /  \/ ( _/ / ___/ -_)  \   / \
 * /___/\__/_/_/ /_/  /_/\__/ /_/ /_/_/_/__/ /_/   \__/_/_/   \|/
 * 
 * Etch your words permanently on the Ethereum blockchain where they will outlive
 * you & create an everlasting record of your thoughts, contemplations & predictions.
 * This is your chance to leave an eternal mark and express your presence in the 
 * digital age while being rewarded with a "Write to Earn" token. 
 * 
 * Deployed to Ethereum: 0x7eae7422f633429EE72BA991Ac293197B80D5976
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Pen is ERC20 {
    uint maxSupply = 1_000_000 * 10 ** decimals();
    uint reward = 1_000 * 10 ** decimals();
    mapping(address => string) public paper;
    mapping(address => bool) public rewarded;
    event LogThis(string msg);

    constructor() ERC20("Pen", "PEN") {}

    function write(string memory _msg) public {
        paper[msg.sender] = _msg;
        emit LogThis(_msg);
        distributeRewards();
    }

    function read(address _writer) public view returns (string memory) {
        return paper[_writer];
    }

    function distributeRewards() internal {
        if (totalSupply() + reward < maxSupply && rewarded[msg.sender] == false) {
            rewarded[msg.sender] = true;
            _mint(msg.sender, reward);
        }
    }
}