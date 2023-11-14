// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract ProxyDeployer {
	address public admin;
	address public proxy;
	constructor(address _implementation) {
		ProxyAdmin adminInstance = new ProxyAdmin(msg.sender);
		admin = address(adminInstance);
		TransparentUpgradeableProxy proxyInstance = new TransparentUpgradeableProxy(_implementation, admin, "");
		proxy = address(proxyInstance);
	}
}