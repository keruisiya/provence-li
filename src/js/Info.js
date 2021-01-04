import contract from 'truffle-contract'
import InfoContract from '@contracts/Info.json'

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

  // get---根据合约 映射结构 addressToIdentity[address] ==Member 结构体中是否有效----因为是public
  // Member{ identity , isVaild}
  // 获取的结构中的  isValid
  existAccout: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        resolve(res[1])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // get---根据合约 映射结构 addressToIdentity[address]  判断当前 地址的身份
  // Member{ identity , isVaild}
  // 获取的是identity
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

  // set---调用合约 setIdentity 设定身份。
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

  // get----获取参与方地址集合的 数组长度---用于后台展示
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

  // get---获取其中一个participateArr[id] 的信息---用于后台展示
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
  // 生产方信息上传
  setProduceInfo: function (farmsID, farmsName, farmsAdd, cowVar, cowSource, feedAqu, feedName) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._setProduceInfo(farmsID, farmsName, farmsAdd, cowVar, cowSource, feedAqu, feedName, {from: window.web3.eth.coinbase})
      .then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 获取生产信息ID数组的元素；
  getproduceId: function (id) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.produceId.call(id)
      .then(int => {
        resolve(int)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToProduce
  getProFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.idToProduce.call(ID)
      .then(json => {
        resolve(json)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 获取生产阶段数据个数；getProlength
  getProlength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getProlength.call()
      .then(length => {
        resolve(length)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 测市json库是否能用
  getJson: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getJson.call()
      .then(string => {
        resolve(string)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // -----------------------------------------------------------------------use.sol

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
