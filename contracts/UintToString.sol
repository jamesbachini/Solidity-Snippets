// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UintToString {

    function uint2string(uint _i) internal pure returns (string memory str) {
        if (_i == 0)  return "0";
        uint j = _i;
        uint length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr);
    }

    function tokenURI(uint _tokenId) public pure returns (string memory) {
        return string.concat("https://jamesbachini.com/", uint2string(_tokenId), ".json");
    }

}