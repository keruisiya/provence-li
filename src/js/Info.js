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

  // 根据address访问映射结构 addressToIdentity[address] == Member
  // Member{ identity, isVaild, isExist, applyDate }
  // 获取的映射 结构中的  isExist
  // 判断用户是否 申请注册
  existAccout: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        resolve(res[2])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 根据address访问 映射结构 addressToIdentity[address] == Member
  // Member{ identity, isVaild, isExist, applyDate }
  // 获取的映射 结构中的  isVaild
  // 判断用户是否 通过管理者验证通过
  // 这个接口有的时候有问题-------------------这是导致页面显示和不显示的原因
  vaildAccout: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        // resolve(res[1])
        resolve(res[1])
        // resolve(res[1])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 根据address访问 映射结构 addressToIdentity[address] == Member
  // Member{ identity, isVaild, isExist, applyDate }
  // 获取的映射 结构中的  identity
  // 获取用户的身份信息
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
  // 根据address访问 映射结构 addressToIdentity[address] == Member
  // Member{ identity, isVaild, isExist, applyDate }
  // 获取的映射 结构中的  applyDate
  // 获取用户的申请时间
  getApplyDate: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.addressToIdentity.call(address).then(res => {
        // res[1]====放回的是结构体Member 上面的 isVaild
        resolve(res[3])
      }).catch(err => {
        reject(err)
      })
    })
  },

  // set会改变合约状态
  // 调用setIdentity 申请身份
  // **from必须得是自己，所以前后一样，其他人不可代替签名----这种情况捕获处理了**
  setIdentity: function (address, identity, date) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.setIdentity(
        address || window.web3.eth.defaultAccount, identity, date,
        {from: address}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // set会改变合约状态
  // 调用confirmIdentity 管理者通过身份验证
  // **from是当前账户；-----结合链上的require---就是必须得是管理者**
  confirmIdentity: function (address) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.confirmIdentity(
        address, {from: window.web3.eth.coinbase}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 与getIdentityArrLength交互
  // 得到的返回值表示participateArr数组的长度
  // 表示所有申请身份的账户的集合
  //  用于后台展示----加载所有数据
  getIdentityArrLength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getIdentityArrLength.call()
      .then(length => {
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 与participateArr交互
  // 得到的返回值表示participateArr[id]这个地址；
  // 表示  申请者地址
  //  用于后台展示
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

  // -----------------------------------------------------------上序都是account.sol中的合约
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
  // 获取第id个生产信息ID数组的元素；
  getproduceId: function (index) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.produceId.call(index)
      .then(id => {
        resolve(id)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToProduce
  getProFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getProJsonbyID.call(ID)
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
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },
  // milking阶段
  setMilkInfo: function (produceId, milkingAddrCode, milkingUser, milkingEnv, milkingTime) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._setMilkingInfo(produceId, milkingAddrCode, milkingUser, milkingEnv, milkingTime, {from: window.web3.eth.coinbase})
      .then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取第id个milk信息ID数组的元素；
  getMilkId: function (index) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.milkingId.call(index)
      .then(id => {
        resolve(id)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToMilking
  getMilkFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getMilkJsonbyID.call(ID)
      .then(json => {
        resolve(json)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取milking阶段数据个数；getMilklength
  getMilklength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getMilklength.call()
      .then(length => {
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },

  // process阶段
  setProcessInfo: function (milkId, processAddr, processName, processTime, balingAddr, balingName, equiSkil) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._setProcessInfo(milkId, processAddr, processName, processTime, balingAddr, balingName, equiSkil, {from: window.web3.eth.coinbase})
      .then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 获取第id个加工阶段信息ID数组的元素；
  getProcessId: function (index) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.processId.call(index)
      .then(id => {
        resolve(id)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToProcess
  getProcessFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getProcessJsonbyID.call(ID)
      .then(json => {
        resolve(json)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取生产阶段数据个数；getProcesslength
  getProcesslength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getProcesslength.call()
      .then(length => {
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },

  // storeExpress阶段
  setStoreExpressInfo: function (commodityId, storeAddr, storeName, storageTime, retirTime, transName, transCode, transTime) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._setStoreExpressInfo(commodityId, storeAddr, storeName, storageTime, retirTime, transName, transCode, transTime, {from: window.web3.eth.coinbase})
      .then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取第id个存储运输阶段信息ID数组的元素；
  getStoreExpressId: function (index) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.storeExpressId.call(index)
      .then(id => {
        resolve(id)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToStoreExpress
  getStoreExpressFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getStoreExpressJsonbyID.call(ID)
      .then(json => {
        resolve(json)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取存储运输阶段数据个数；getStoreExpresslength
  getStoreExpresslength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getStoreExpresslength.call()
      .then(length => {
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },

  // sell阶段
  setSellInfo: function (commodityId, sellCode, sellName, sellTime, sellAddr, produDate) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._setSellInfo(commodityId, sellCode, sellName, sellTime, sellAddr, produDate, {from: window.web3.eth.coinbase})
      .then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 获取第id个 销售阶段 信息ID数组的元素；
  getSellId: function (index) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.sellId.call(index)
      .then(id => {
        resolve(id)
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 根据ID查找对应的溯源信息 与mapping的结构有关 idToSell
  getSellFromID: function (ID) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getSellJsonbyID.call(ID)
      .then(json => {
        resolve(json)
      }).catch(err => {
        reject(err)
      })
    })
  },

  // 获取销售 阶段数据个数；getSelllength
  getSelllength: function () {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.getSelllength.call()
      .then(length => {
        resolve(length.toNumber())
      }).catch(err => {
        reject(err)
      })
    })
  },

  getRandom: function (num) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance._paddingZero.call(num)
      .then(str => {
        resolve(str)
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
