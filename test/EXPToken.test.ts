import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { MockProvider } from "ethereum-waffle";
import { BigNumberish, Wallet } from "ethers";
import { ethers } from "hardhat";
import { EXPToken, EXPToken__factory } from "../typechain";

describe("EXPToken", function () {
  let EXPTokenFactory: EXPToken__factory;
  let EXPToken: EXPToken;
  let aliceWallet: Wallet;
  let bobWallet: Wallet;
  // aliceSigner = ethers.getSigner;
  [aliceWallet, bobWallet] = new MockProvider().getWallets();
  const AMOUNT: BigNumberish = ethers.utils.parseEther("10");

  before(async () => {
    EXPTokenFactory = await ethers.getContractFactory("EXPToken");
    EXPToken = await EXPTokenFactory.deploy();
    await EXPToken.deployed();
    // aliceSigner = await ethers.getSigner();
  })

  beforeEach(async () => {
    // EXPToken.mint(aliceSigner.address, AMOUNT);
    EXPToken.mint(aliceWallet.address, AMOUNT);
  })

  it("Alice balance should be equal to 100 tokens", async function () {
    expect(EXPToken.balanceOf(aliceWallet.address)).eq(ethers.BigNumber.from(10));
  });

  it("A TransferDisabled event should be emitted after having minted tokens", async function () {
    await expect(EXPToken.emit("TransferDisabled"));
  });

  it("Call transfer() should not work after having minted tokens", async function () {
    await expect(EXPToken.transfer(bobWallet.address, ethers.utils.parseEther("0.01"))).to.be.revertedWith("Non-transferrable token");
    await expect(EXPToken.transfer(aliceWallet.address, ethers.utils.parseEther("0.01"))).to.be.revertedWith("Non-transferrable token");
  });

  it("Call transferFrom() should not work after having minted tokens", async function () {
    await expect(EXPToken.transferFrom(aliceWallet.address, bobWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
    await expect(EXPToken.transferFrom(aliceWallet.address, aliceWallet.address, AMOUNT)).to.be.revertedWith("Non-transferrable token");
  });

  it("Call approve() should not work after having minted tokens", async function () {
    await expect(EXPToken.approve(bobWallet.address, AMOUNT)).to.be.reverted;
    await expect(EXPToken.approve(aliceWallet.address, AMOUNT)).to.be.reverted;
  });

});
