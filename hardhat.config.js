require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const ALCHEMY_API_KEY = // your Alchemy (or node provider of your choice) API_Key;
const PRIVATE_KEY = // your wallet PRIVATE_KEY;
const ETHERSCAN_API_KEY = // your ETHERSCAN_API_KEY to submit the project to Etherscan;
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan: { /// submitt the project to etherscan 
    apiKey: ETHERSCAN_API_KEY
  }
};


