import { expect } from "chai";
import { MockProvider } from "ethereum-waffle";
import { BigNumberish, Contract, Wallet } from "ethers";
import { ethers } from "hardhat";
import { EXPToken, EXPToken__factory } from "../typechain";

describe("EXPToken - Alice is allowed to mint tokens", function () {
  let EXPTokenFactory: EXPToken__factory;
  let EXPToken: EXPToken;
  let aliceWallet: Wallet;
  let bobWallet: Wallet;
  [aliceWallet, bobWallet] = new MockProvider().getWallets();
  const AMOUNT: BigNumberish = ethers.utils.parseUnits("10", 18);

  before(async () => {
    EXPTokenFactory = await ethers.getContractFactory("EXPToken");
    EXPToken = await EXPTokenFactory.deploy();
    await EXPToken.deployed();
    await EXPToken.setApprovedMinter(aliceWallet.address, true);
    await EXPToken.mint(aliceWallet.address, AMOUNT);
  })

  it("A TransferDisabled event should be emitted after having minted tokens", async function () {
    await expect(EXPToken.mint(aliceWallet.address, AMOUNT))
      .to.emit(EXPToken, "TransferDisabled")
      .withArgs(aliceWallet.address)
  });

  it("Bob should not be able to mint", async function () {
    await expect(EXPToken.mint(bobWallet.address, AMOUNT)).to.be.revertedWith("No minting permissions");
  });

  it("Alice balance should be equal to 200 tokens", async function () {
    expect(await EXPToken.balanceOf(aliceWallet.address)).to.equal(AMOUNT.mul(2));
  });

  it("transfer() should not work after having minted tokens", async function () {
    await expect(EXPToken.transfer(aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

  it("transferFrom() should not work after having minted tokens", async function () {
    await expect(EXPToken.transferFrom(aliceWallet.address, aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

  it("approve() should not work after having minted tokens", async function () {
    await expect(EXPToken.approve(aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

});
