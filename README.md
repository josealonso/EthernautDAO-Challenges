### EthernautDAO Bounties (May-10-2022)

#### 1st Bounty: Create a soulbound ERC20 token called (EXP). (500$)

- Implement a setApprovedMinter(address, bool) onlyOwner function 
- No limit on total supply
- Transfer capabilities must be disabled after minting (soulbound)


#### 2nd Bounty: Create a nontransferable mutable NFT. Mintable NFT, nontransferable capable of reading and displaying how many EXP tokens you have (1000$)

- Create a fully on-chain generative ASCII art showing numbers from 1 to 100
- All mints start with the number 0
- The number shown by the NFT must reflect the EXP balance of the owner on the NFT
- Transfer capabilities must be disabled after minting (soulbound)




```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```
