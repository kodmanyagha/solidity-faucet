/* For executing this script you have to set network in cli. For example:

  npx hardhat run --network localhost scripts/index.ts

*/

import { ethers } from "hardhat";
import { Box } from "../typechain-types";

(async () => {
  const provider = new ethers.JsonRpcProvider();
  const accounts = await provider.listAccounts();
  console.log(">>  accounts:", accounts);

  const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
  const Box = await ethers.getContractFactory("Box");
  const box = (await Box.attach(contractAddress)) as Box;

  let value = await box.retrieve();
  console.log("Old box value is", value.toString());

  await box.store(parseInt(value.toString()) + 1);

  value = await box.retrieve();
  console.log("Box value is", value.toString());
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
