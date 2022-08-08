// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MYTKN") {
        _mint(msg.sender, 1e30);
    }
}

contract Deployer {
    address public myToken;
    constructor() {
        myToken = address(new MyToken());
    }
    // Contract owns all the tokens
}
