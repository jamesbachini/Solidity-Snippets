// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract StoringData {
    function setDataToMemeory(uint256 newValue) public {
        assembly {
            sstore(0, newValue)
        }
    }

    function getDataFromMemory() public view returns(uint256) {
        assembly {
            let v := sload(0)
            mstore(0x80, v)
            return(0x80, 32)
        }
    }
}

contract SendETH {
    address[2] owners = [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0xdD870fA1b7C4700F2BD7f44238821C26f7392148];
    function withdrawETH(address _to, uint256 _amount) external payable {
        bool success;
        assembly {
            for { let i := 0 } lt(i, 2) { i := add(i, 1) } {
                let owner := sload(i)
                if eq(_to, owner) {
                    success := call(gas(), _to, _amount, 0, 0, 0, 0)
                } 
            }
        }
        require(success, "Failed to send ETH");
    }
}

contract UselessEncryption {
    function encrypt(string memory _input, bool _decrypt) external pure returns (string memory) {
        bytes32 output;
        assembly {
            function stringToBytes(a) -> b {
                b := mload(add(a, 32))
            }
            function addToBytes(bs,decrypt) -> r {
                if eq(decrypt, false) {
                    mstore(0x0, add(bs,0x0101010101010101010101010101010101010101010101010101010101010101))
                } 
                if eq(decrypt, true) {
                    mstore(0x0, sub(bs,0x0101010101010101010101010101010101010101010101010101010101010101))
                }
                r := mload(0x0)
            }
            let byteString := stringToBytes(_input)
            output := addToBytes(byteString,_decrypt)
        }
        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) bytesArray[i] = output[i];
        return string(bytesArray);
    }
}