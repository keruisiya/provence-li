<template>
<div>
  <keep-alive>
    <component :is='currentComponent' :currentAccount='currentAccount' :currentIdentity='currentIdentity'> </component>  
  </keep-alive>  
  <div class="test">
    <el-button type="primary" @click="test1" style="float:left">测试set</el-button>
		<el-button @click="test2">测试get</el-button>
  </div>
</div>
  
</template>

<script>
import Info from '@/js/info'
import Account from './components/Account.vue'
import Upload from './components/Upload.vue'

export default {
  name: 'Paticipator',
  data () {
    return {
      msg: '账户的身份设定',
      currentAccount: '',
      currentIdentity: '',
      currentComponent: ''
    }
  },
  components: {
    Account,
    Upload
  },
  computed: {
  },
  beforeCreate: function () {
    Info.init().then(() => {
      Info.vaildAccout(window.web3.eth.coinbase).then((exist) => {
        // 已完成注册的用户
        console.log(exist)
        if (exist) {
          this.currentComponent = 'Upload'
          Info.getCurrIden(window.web3.eth.coinbase).then((identity) => {
            // 合约上获取的不是 首字母不是大写
            console.log(identity)
            this.currentIdentity = identity.charAt(0).toUpperCase() + identity.slice(1)
          })
        } else {
         // 未完成注册的用户
          this.currentComponent = 'Account'
          // this.currentComponent = 'Upload'
        }
      })
    })
  },
  mounted () {
    this.currentAccount = window.web3.eth.coinbase
    // this.currentAccount = window.metamask.eth.coinbase
  },
  methods: {
    test1 () {
      // 测试生产者一方接口
      // Info.setProduceInfo('12', 'fad', 'a', 'adf', 'a', 'dfa', 'ad').then(function (res) {
      //   console.log(res)    // 这个输出的是交易
      //   console.log(res.logs)// 这里会返回相关值
      //   // 想操作事件
      //   for (var i = 0; i < res.logs.length; i++) {
      //     var log = res.logs[i]
      //     if (log.event === 'ProduceDateAdded') {
      //       console.log('from:', log.args)
      //       // console.log('to:', log.args._to)
      //       // console.log('amount:', log.args._value.toNumber())
      //       break
      //     }
      //   }
      // }, function (err) {
      //   console.log(err)
      // })

      // 测试milk部分得接口
      // Info.setMilkInfo('66238', 'mikling', 'xiaohua', 'jiushimeng', 'dfasdfasdd').then(function (res) {
      //   console.log(res)    // 这个输出的是交易
      //   console.log(res.logs)// 这里会返回相关值
      //   // 想操作事件
      // }, function (err) {
      //   console.log(err)
      // })
      // 测试process得接口
      // Info.setProcessInfo('0133566238', '地址', '小明', '2020-1-5', 'dfasdf', '2123', '123uzi').then(function (res) {
      //   console.log(res)    // 这个输出的是交易
      //   console.log(res.logs)// 这里会返回相关值
      //   // 想操作事件
      // }, function (err) {
      //   console.log(err)
      // })
      // 测试storeExpress接口
      // Info.setStoreExpressInfo('416110133566238', '江苏省南京市', 'keruisiya', '2020-1-5', 'jkl', '2123', 'lwx3uzi', 'langx').then(function (res) {
      //   console.log(res)    // 这个输出的是交易
      //   console.log(res.logs)// 这里会返回相关值
      //   // 想操作事件
      // }, function (err) {
      //   console.log(err)
      // })
      // // // 测试sell得接口
      // Info.setSellInfo('416110133566238', '0001', 'clearlove', '2020-1-5', '安徽安庆', 'rngedg').then(function (res) {
      //   console.log(res)    // 这个输出的是交易
      //   console.log(res.logs)// 这里会返回相关值
      //   // 想操作事件
      // }, function (err) {
      //   console.log(err)
      // })
    },
    test2 () {
      // 测试设置生产设信息的部分合约
      Info.getproduceId(0).then(function (id) {
        console.log(id)
      }, function (err) {
        console.log(err)
      })
      Info.getProlength().then(function (res) {
        console.log(res)
      }, function (err) {
        console.log(err)
      })
      // Info.getProFromID('54046').then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })

      // // 测试milk设置信息得部分合约getMilkId，getMilkFromID,getMilklength
      Info.getMilkId(0).then(function (id) {
        console.log(id)
      }, function (err) {
        console.log(err)
      })
      // Info.getMilklength().then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // Info.getMilkFromID('').then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })

      // // 测试process设置信息得部分接口
      Info.getProcessId(0).then(function (id) {
        console.log(id)
      }, function (err) {
        console.log(err)
      })
      // Info.getProcesslength().then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // Info.getProcessFromID('57144460082437').then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // // 测试storeExpress阶段得接口
      // Info.getStoreExpressId(0).then(function (id) {
      //   console.log(id)
      // }, function (err) {
      //   console.log(err)
      // })
      Info.getStoreExpresslength().then(function (res) {
        console.log(res)
      }, function (err) {
        console.log(err)
      })
      // Info.getStoreExpressFromID('57144460082437').then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // // 测试sell阶段得接口：
      Info.getSellId(0).then(function (id) {
        console.log(id)
      }, function (err) {
        console.log(err)
      })
      // Info.getSelllength().then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // Info.getSellFromID('57144460082437').then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
    }
  }
}
</script>

<style scoped>



</style>
