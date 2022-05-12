import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { deployContract, MockProvider } from "ethereum-waffle";
import { BigNumberish, Contract, Wallet } from "ethers";
import { ethers } from "hardhat";
import { EXPToken, EXPToken__factory } from "../typechain";

describe("EXPToken - Alice mints tokens", function () {
  let EXPTokenFactory: EXPToken__factory;
  let EXPToken: EXPToken;
  let aliceWallet: Wallet;
  let bobWallet: Wallet;
  let token: Contract;
  // aliceSigner = ethers.getSigner;
  [aliceWallet, bobWallet] = new MockProvider().getWallets();
  const AMOUNT: BigNumberish = ethers.utils.parseUnits("10", 18);

  before(async () => {
    EXPTokenFactory = await ethers.getContractFactory("EXPToken");
    EXPToken = await EXPTokenFactory.deploy();
    await EXPToken.deployed();
  })

  beforeEach(async () => {
    EXPToken.mint(aliceWallet.address, AMOUNT);
  })

  it("Alice balance should be equal to 100 tokens", async function () {
    // expect(await EXPToken.balanceOf(aliceWallet.address)).to.equal(10);
    expect(await EXPToken.balanceOf(aliceWallet.address)).to.equal(ethers.utils.parseUnits("10", 18));
  });

  it("A TransferDisabled event should be emitted after having minted tokens", async function () {
    await expect(EXPToken.emit("TransferDisabled"));
  });

  it("transfer() should not work after having minted tokens", async function () {
    // await expect(EXPToken.transfer(bobWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
    await expect(EXPToken.transfer(aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

  it("transferFrom() should not work after having minted tokens", async function () {
    // await expect(EXPToken.transferFrom(aliceWallet.address, bobWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
    await expect(EXPToken.transferFrom(aliceWallet.address, aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

  it("approve() should not work after having minted tokens", async function () {
    await expect(EXPToken.approve(aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
    // await expect(EXPToken.approve(bobWallet.address, ethers.utils.parseUnits("1", 18))).
  });

});
