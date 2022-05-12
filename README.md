# EthernautDAO Bounties (May-10-2022)

### 1st Bounty: Create a soulbound ERC20 token called (EXP). (500$)

- Implement a setApprovedMinter(address, bool) onlyOwner function 
- No limit on total supply
- Transfer capabilities must be disabled after minting (soulbound)

#### Solutions ----> *EXPToken.sol* inherits from *SoulboundERC20.sol*

#### Tests coverage

`npx hardhat coverage`

```
 EXPToken - Alice is allowed to mint tokens
    ✔ A TransferDisabled event should be emitted after having minted tokens (296ms)
    ✔ Bob should not be able to mint (384ms)
    ✔ Alice balance should be equal to 200 tokens (169ms)
    ✔ transfer() should not work after having minted tokens (317ms)
    ✔ transferFrom() should not work after having minted tokens (334ms)
    ✔ approve() should not work after having minted tokens (357ms)

  6 passing (5s)

---------------------|----------|----------|----------|----------|----------------|
File                 |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
---------------------|----------|----------|----------|----------|----------------|
 contracts/          |       50 |       50 |    61.54 |    48.65 |                |
  EXPToken.sol       |      100 |      100 |      100 |      100 |                |
  SoulboundERC20.sol |    46.67 |       50 |    55.56 |    45.71 |... 127,150,155 |
---------------------|----------|----------|----------|----------|----------------|
All files            |       50 |       50 |    61.54 |    48.65 |                |
---------------------|----------|----------|----------|----------|----------------|
```

### 2nd Bounty: Create a nontransferable mutable NFT. Mintable NFT, nontransferable capable of reading and displaying how many EXP tokens you have (1000$)

- Create a fully on-chain generative ASCII art showing numbers from 1 to 100
- All mints start with the number 0
- The number shown by the NFT must reflect the EXP balance of the owner on the NFT
- Transfer capabilities must be disabled after minting (soulbound)

### 3rd Bounty: Create a 1 time hackable lvl. (500$)

- Create a hackable smart contract
- Contact Dhante from EthernautDAO
- Get the smart contract verified and receive (3 EXP) + ($500)
- The DAO deploys the contract and announces it
- Someone hacks the contract (1 EXP)
- Someone writes an article on how this smart contract was solved (3 EXP)
