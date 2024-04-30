import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Faucet } from "../typechain-types";

describe("Faucet", function () {
  async function deployContract() {
    const [owner, otherAccount] = await ethers.getSigners();

    const Faucet = await ethers.getContractFactory("Faucet");
    const faucet = (await Faucet.deploy()) as Faucet;

    return {
      faucet,
      owner,
      otherAccount,
    };
  }

  describe("Deployment", function () {
    it("Should name set", async function () {
      const { faucet } = await loadFixture(deployContract);
      const testName = "Test Name";

      await faucet.addName(testName);
      expect(await faucet.getName(0)).to.equal(testName);
      expect(await faucet.getName(1)).to.equal("");
    });
  });

  describe("Invoking functions", () => {
    it("Should invoke receive() fn", async () => {
      const { faucet } = await loadFixture(deployContract);

      const faucetAddr = await faucet.getAddress();
      const [owner] = await ethers.getSigners();
      const tx = { to: faucetAddr, value: ethers.parseEther("1.0") };
      await owner.sendTransaction(tx);

      const contractBalance = await ethers.provider.getBalance(faucetAddr);
      expect(contractBalance).to.equal(ethers.parseEther("1.0"));
    });
  });
});
