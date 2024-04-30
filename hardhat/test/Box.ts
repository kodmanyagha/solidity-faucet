import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Box", function () {
  async function deployContract() {
    const [owner, otherAccount] = await ethers.getSigners();

    const Box = await ethers.getContractFactory("Box");
    const box = await Box.deploy();

    return { box, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should value zero", async function () {
      const { box } = await loadFixture(deployContract);

      expect(await box.retrieve()).to.equal(0);
    });
  });
});
