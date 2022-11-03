// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MyNFT is ERC721 {
    uint256 public tokenId;
    uint256 public maxSupply = 1000;

    constructor() ERC721("My NFT", "MFT") {
    }

    function tokenURI(uint256) override public pure returns (string memory) {
        string memory json = Base64.encode(bytes(string(
            abi.encodePacked('{"name": "My NFT", "description": "Whatever", "image": "https://ethereumhacker.com/img/nft.png"}')
        )));
        return string(abi.encodePacked('data:application/json;base64,', json));
    }

    function mint() public {
        require(tokenId < maxSupply, "All tokens have been minted");
        _safeMint(msg.sender, tokenId);
        tokenId = tokenId + 1;
    }
}