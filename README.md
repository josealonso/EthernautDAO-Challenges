### EthernautDAO Bounties (May-10-2022)

#### 1st Bounty: Create a soulbound ERC20 token called (EXP). (500$)

- Implement a setApprovedMinter(address, bool) onlyOwner function 
- No limit on total supply
- Transfer capabilities must be disabled after minting (soulbound)

Solutions ----> *EXPToken.sol* inherits from *SoulboundERC20.sol*

#### 2nd Bounty: Create a nontransferable mutable NFT. Mintable NFT, nontransferable capable of reading and displaying how many EXP tokens you have (1000$)

- Create a fully on-chain generative ASCII art showing numbers from 1 to 100
- All mints start with the number 0
- The number shown by the NFT must reflect the EXP balance of the owner on the NFT
- Transfer capabilities must be disabled after minting (soulbound)

#### 3rd Bounty: Create a 1 time hackable lvl. (500$)

- Create a hackable smart contract
- Contact Dhante from EthernautDAO
- Get the smart contract verified and receive (3 EXP) + ($500)
- The DAO deploys the contract and announces it
- Someone hacks the contract (1 EXP)
- Someone writes an article on how this smart contract was solved (3 EXP)
