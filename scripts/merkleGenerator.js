const {MerkleTree} = require("merkletreejs");
const keccak256 = require("keccak256");
const whitelist = ['0x6090A6e47849629b7245Dfa1Ca21D94cd15878Ef','0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8'];
const leaves = whitelist.map(addr => keccak256(addr));
const merkleTree = new MerkleTree(leaves, keccak256, {sortPairs: true});
const rootHash = merkleTree.getRoot().toString('hex');
console.log(`Whitelist Merkle Root: 0x${rootHash}`);
whitelist.forEach((address) => {
  const proof =  merkleTree.getHexProof(keccak256(address));
  console.log(`Adddress: ${address} Proof: ${proof}`);
});
