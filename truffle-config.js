module.exports = {
  // 本地localhost 起ganache-cli
  // truffle部署的provoider----window上面的onload事件中就不需要改了
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*'// Match any network id
    }
  },
  // 另一台用 --host参数起ganache-cli
  // networks: {
  //   development: {
  //     host: '192.168.0.110',
  //     port: 8545,
  //     network_id: '*' // Match any network id
  //   }
  // },
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
