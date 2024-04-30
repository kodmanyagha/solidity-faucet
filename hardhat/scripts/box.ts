import { ethers } from "hardhat";

(async () => {
  const Box = await ethers.getContractFactory("Box");
  console.log("Deploying box...");
  const box = await Box.deploy();
  await box.waitForDeployment();
  console.log("Box deployed to: ", await box.getAddress());
})()
  .then(() => process.exit(0))
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });
