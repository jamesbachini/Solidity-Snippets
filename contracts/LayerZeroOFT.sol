// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
    // https://layerzero.gitbook.io/docs/technical-reference/testnet/testnet-addresses
    Goerli          lzEndpointAddress = 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23
    chainId: 10121  deploymentAddress = 
    Optimism-Goerli lzEndpointAddress = 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1
    chainId: 10132  deploymentAddress = 
*/
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/token/oft/OFTCore.sol";
import "https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/token/oft/IOFT.sol";

contract LayerZeroOFT is OFTCore, ERC20, IOFT {
    address constant lzEndpointAddress = 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23;

    constructor() ERC20("LayerZeroOFT", "LZOFT") OFTCore(lzEndpointAddress) {
        if (block.chainid == 5) { // Only mint initial supply on Goerli
            _mint(msg.sender, 1_000_000 * 10 ** decimals());
        }
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(OFTCore, IERC165) returns (bool) {
        return interfaceId == type(IOFT).interfaceId || interfaceId == type(IERC20).interfaceId || super.supportsInterface(interfaceId);
    }

    function token() public view virtual override returns (address) {
        return address(this);
    }

    function circulatingSupply() public view virtual override returns (uint) {
        return totalSupply();
    }

    function _debitFrom(address _from, uint16, bytes memory, uint _amount) internal virtual override returns(uint) {
        address spender = _msgSender();
        if (_from != spender) _spendAllowance(_from, spender, _amount);
        _burn(_from, _amount);
        return _amount;
    }

    function _creditTo(uint16, address _toAddress, uint _amount) internal virtual override returns(uint) {
        _mint(_toAddress, _amount);
        return _amount;
    }
}