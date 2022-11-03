// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
  This contract shows how to send tokens and ETH to multiple addresses.
  Can easily handle 500 addresses in a single transaction via remix, perhaps more.
  Send ETH and tokens to the contract prior to executing sendOutFunds
*/

contract BulkSend is Ownable {
    address token = 0x2f3A40A3db8a7e3D09B0adfEfbCe4f6F81927557; // Token Contract Address (Goerli USDC)
    uint tokenAmount = 5000 * 1e6; // 5000 tokens
    uint ethAmount = 5000000000000000; // 0.005 ETH

    function sendOutFunds(address[] memory _to) public onlyOwner {
        for (uint i = 0; i < _to.length; i++) {
            IERC20(token).transfer(_to[i], tokenAmount);
            payable(_to[i]).transfer(ethAmount);
        }
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function reclaimToken(IERC20 token) public onlyOwner {
        require(address(token) != address(0));
        uint balance = token.balanceOf(address(this));
        token.transfer(msg.sender, balance);
    }

    receive() external payable {}
    fallback() external payable {}
}