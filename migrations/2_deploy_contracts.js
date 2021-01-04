var Info = artifacts.require('./Info.sol')
var LibInt = artifacts.require('./utils/LibInt.sol')
var LibString = artifacts.require('./utils/LibString.sol')

module.exports = function (deployer) {
  // deployer.deploy(Users)
  deployer.deploy(LibInt)
  deployer.deploy(LibString)

  deployer.link(LibInt, Info)
  deployer.link(LibString, Info)
  deployer.deploy(Info)
}
