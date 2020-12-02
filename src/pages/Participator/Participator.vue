<template>
  <div id='wrapper'>
    <div>
        当前账户地址：{{ currentAccount }}
    </div>
    <keep-alive>
      <component :is='currentComponent' :currentAccount='currentAccount' :currentIdentity='currentIdentity'> </component>
    </keep-alive>   
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
      Info.existAccout(window.web3.eth.coinbase).then((exist) => {
        // 已完成注册的用户
        if (exist) {
          this.currentComponent = 'Upload'
          Info.getCurrIden(window.web3.eth.coinbase).then((identity) => {
            // 合约上获取的不是 首字母不是大写
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
  }
}
</script>

<style scoped>
#wrapper{
  width: 500px;
  margin:0 auto;
}



</style>
