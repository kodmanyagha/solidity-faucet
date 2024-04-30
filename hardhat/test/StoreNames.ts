import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("StoreNames", async () => {
  async function deployContract() {
    const [owner, account1, account2, account3] = await ethers.getSigners();
    const StoreNamesFactory = await ethers.getContractFactory("StoreNames");
    const contract = await StoreNamesFactory.deploy();

    return {
      contract,
      owner,
      account1,
      account2,
      account3,
    };
  }

  describe("Deployment", async () => {
    it("Should be deployed", async () => {
      const fixture = await loadFixture(deployContract);

      await expect(await fixture.contract.addName("test"))
        .to.emit(fixture.contract, "AddedNewName")
        .withArgs(fixture.owner, "test");
    });

    it("Should be added name", async () => {
      const fixture = await loadFixture(deployContract);

      await expect(await fixture.contract.addName("test"))
        .to.emit(fixture.contract, "AddedNewName")
        .withArgs(fixture.owner, "test");

      await expect(await fixture.contract.getName(0)).to.equal("test");

      // For catching errors not wait inside expect, and then use `eventually.to.rejectedWith`
      await expect(fixture.contract.getName(1)).eventually.to.rejectedWith(
        Error,
        "VM Exception while processing transaction: reverted with panic code 0x32 (Array accessed at an out-of-bounds or negative index)"
      );
    });
  });

  describe("Transfer", async () => {
    it("Should be transfered", async () => {
      const fixture = await loadFixture(deployContract);

      const txResult = await fixture.account1.sendTransaction({
        to: await fixture.contract.getAddress(),
        value: ethers.parseEther("0.00123"),
      });

      console.log(">> BLOCK HASH", txResult.blockHash);

      await expect(txResult.blockHash?.length).to.equal(66);
    });
  });
});
