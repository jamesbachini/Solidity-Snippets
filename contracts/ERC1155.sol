// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MyNFT is ERC1155 {
    uint256 public constant gameItem1 = 1;
    uint256 public constant gameItem2 = 2;
    uint256 public constant gameItem3 = 3;

    constructor() ERC1155("https://ethereumhacker.com/nfts/{id}.json") {
        _mint(msg.sender, gameItem1, 1, "");
        _mint(msg.sender, gameItem2, 1, "");
        _mint(msg.sender, gameItem3, 100, "");
    }
}