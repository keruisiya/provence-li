import contract from 'truffle-contract'
import InfoContract from '@contracts/Info.json'

const Info = {

  contract: null,

  instance: null,

  init: function () {
    let self = this
    return new Promise(function (resolve, reject) {
      self.contract = contract(InfoContract)
      self.contract.setProvider(window.web3.currentProvider)
      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },
  // 先不管就加上一个call
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

  produceArr: function (id) {
    let self = this
    return new Promise((resolve, reject) => {
      self.instance.produceArr.call(id).then(res => console.log(res))
    })
  },

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
