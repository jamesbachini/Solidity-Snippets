// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

interface EACAggregatorProxy {
  function latestAnswer() external view returns (int256);
}

// Get ETH price from Chainlink oracle service
contract PainLink {
  
    int256 public ethPrice = 0;
    address public chainLinkETHUSDAddress = 0x9326BFA02ADD2366b30bacB125260Af641031331; // Kovan, more addresses here: https://docs.chain.link/docs/reference-contracts/

    function updateEthPrice() public returns (int256) {
      ethPrice = EACAggregatorProxy(chainLinkETHUSD).latestAnswer();
    }
}
