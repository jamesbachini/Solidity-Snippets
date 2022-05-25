// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is ERC20 {
  IERC20 public immutable token;

  constructor(address _token) ERC20("Vault Receipt Token", "RECEIPT") {
    token = IERC20(_token);
  }

  function deposit(uint _amount) external {
    uint receiptTokens;
    if (totalSupply() == 0) {
      receiptTokens = _amount;
    } else {
      receiptTokens = (_amount * totalSupply()) / token.balanceOf(address(this));
    }
    _mint(msg.sender, receiptTokens);
    token.transferFrom(msg.sender, address(this), _amount);
  }

  function withdraw(uint _receiptTokens) external {
    uint amount = (_receiptTokens * token.balanceOf(address(this))) / totalSupply();
    _burn(msg.sender, _receiptTokens);
    token.transfer(msg.sender, amount);
  }
}
