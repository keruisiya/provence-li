module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      // gas: 500000,
      network_id: '*' // Match any network id
    }
  },
  compilers: {
    solc: {
      version: '0.4.19'    // Fetch exact version from solc-bin (default: truffle's version),从solc-bin中获取确切的版本（默认值：松露的版本）
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false),使用您在docker本地安装的“ 0.5.1”（默认值：false）
      // settings: {          // See the solidity docs for advice about optimization and evmVersion,请参见solidity文档，以获取有关优化和evmVersion的建议
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
}
