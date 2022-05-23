// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
  
  bool paused = true;

  constructor() ERC20("My Paused Token", "TOKEN") {
    _mint(msg.sender, 1000000);
  }

  function letsGo() external {
    paused = false;
  }

  function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20) {
    super._beforeTokenTransfer(from, to, amount);
    require(paused == false, "Token transfer is paused");
  }
}