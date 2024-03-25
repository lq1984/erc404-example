import "dotenv/config"
import { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import "hardhat-gas-reporter"
import "@nomicfoundation/hardhat-ignition-ethers";

const config: {
  gasReporter: { currency: string; enabled: boolean; gasPrice: number };
  etherscan: {
    apiKey: { testnet: string };
    customChains: { urls: { apiURL: string; browserURL: string }; chainId: number; network: string }[]
  };
  paths: { cache: string; tests: string; sources: string; artifacts: string };
  networks: { testnet: { accounts: string[]; url: string } };
  solidity: { compilers: ({ version: string } | { version: string })[]; evmVersion: string }
} = {
  solidity: {
    compilers: [
        { version: "0.8.20" },
      { version: "0.4.18" }
    ],
    evmVersion: 'london',
  },
  etherscan: {
    apiKey: {
      testnet: "xxx"
    },
    customChains: [
      {
        network: "testnet",
        chainId: 90001,
        urls: {
          apiURL: "https://testnet.starscan.io/evm/api",
          browserURL: "https://testnet.starscan.io/evm"
        }
      }
    ]
  },
  gasReporter: {
    currency: "USD",
    gasPrice: 21,
    enabled: true,
  },
  networks: {
    testnet: {
      url: `https://testnet-fx-json-web3.functionx.io:8545`,
      accounts: [],
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
}

export default config
