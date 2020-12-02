import contract from 'truffle-contract'
import InfoContract from '@contracts/Info.json'
// import OwnableContract from '@contracts/Ownable.json'
// import UtilsContract from '@contracts/Utils.json'
// import AccountContract from '@contracts/Account.json'

const Info = {

  contract: null,

  instance: null,
  // 合约实例化接口
  init: function () {
    let self = this
    return new Promise(function (resolve, reject) {
      self.contract = contract(InfoContract)
      // , OwnableContract, UtilsContract, AccountContract
      self.contract.setProvider(window.web3.currentProvider)
      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 根据合约 映射结构 addressToIdentity[address] ==Member 结构体中是否有效----因为是public
  // Member{ identity , isVaild}
  existAccout: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        // res[1]====放回的是结构体Member 上面的 isVaild
        resolve(res[1])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 根据合约 映射结构 addressToIdentity[address]  判断当前 地址的身份
  // Member{ identity , isVaild}
  getCurrIden: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        // res[1]====放回的是结构体Member 上面的 isVaild
        resolve(res[0])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 调用合约 setIdentity 设定身份。
  setIdentity: function (address, identity) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.setIdentity(
        address || window.web3.eth.defaultAccount, identity,
        {from: address}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取参与方地址集合的 数组长度---用于后台展示
  getIdentityArrLength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getIdentityArrLength.call()
      .then(length => {
        resolve(length)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取其中一个participateArr[id] 的信息---用于后台展示
  getParticipate: function (id) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.participateArr.call(id)
      .then(address => {
        resolve(address)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 打算不用这个
  // getIdentity: function (address) {
  //   let self = this
  //   return new Promise((resolve, reject) => {
  //     self.instance.getIdentity.call(address)
  //     .then(identity => {
  //       resolve(identity)
  //     }).catch(err => {
  //       reject(err)
  //     })
  //   })
  // },
  exists: function (address) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.exists.call(
        address || window.web3.eth.defaultAccount,
        {from: window.web3.eth.accounts[0]}
      ).then(exists => {
        resolve(exists)
      }).catch(err => {
        reject(err)
      })
    })
  },

  authenticate: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.authenticate.call(
        {from: window.web3.eth.accounts[0]}
      ).then(pseudo => {
        resolve(window.web3.toUtf8(pseudo))
      }).catch(err => {
        reject(err)
      })
    })
  },

  create: function (pseudo) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.create(
        pseudo,
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  destroy: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.destroy(
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default Info
