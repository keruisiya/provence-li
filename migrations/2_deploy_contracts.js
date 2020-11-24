// var Users = artifacts.require('./Users.sol')
var Info = artifacts.require('./Info.sol')

module.exports = function (deployer) {
  // deployer.deploy(Users)
  deployer.deploy(Info)
}
