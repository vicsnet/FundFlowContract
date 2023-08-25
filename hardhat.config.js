require("@nomicfoundation/hardhat-toolbox");
require ("hardhat-preprocessor")
const fs = require ("fs")
// import fs from "fs"
function getRemappings() {
  return fs
    .readFileSync("remappings.txt", "utf8")
    .split("\n")
    .filter(Boolean) // remove empty lines
    .map((line) => line.trim().split("="));
}

const BASE_PRIVATE_KEY = "9cd05b640ea002da792e39447101739a2bf3438374329ddfc6b47f17b6628c2b";
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  preprocess: {
    eachLine: (hre) => ({
      transform: (line) => {
        if (line.match(/^\s*import /i)) {
          for (const [from, to] of getRemappings()) {
            if (line.includes(from)) {
              line = line.replace(from, to);
              break;
            }
          }
        }
        return line;
      },
    }),
  },
  paths: {
    sources: "./src",
    cache: "./cache_hardhat",
  },
  networks: {
    base: {
      url: `https://base-goerli.rpc.thirdweb.com`,
      accounts: [BASE_PRIVATE_KEY],
      gasPrice: 35000000000,
    },
  },
  etherscan: {
    apiKey: "V31R324BWIZN1CZXXBXCS4VTEAXMXZHM65",
  },
};
