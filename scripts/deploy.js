// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
      // const Factory = await ethers.getContractFactory("FFFactory");
      const Child = await ethers.getContractFactory("FundFlowContract");
      // const factory = await Factory.deploy();
      const child = await Child.deploy("0xe78Fc55c884704F9485EDa042fb91BfE16fD55c1");
      // await factory.deployed();
      await child.deployed();
      
  // console.log(
  //   `Factory is deployed at ${factory.address}`
  // );
  console.log(
    `Child is deployed at ${child.address}`
  );
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
