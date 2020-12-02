<template>
  <div>
    <div>
      当前账户地址：{{ currentAccount }}
    </div>
    <h1>账户设定信息</h1>
    <div id="table"> 
      <pro-table :tableData="tableData"></pro-table>
    </div>
  </div>
</template>

<script>
import Info from '@/js/info'
import ProTable from '@/components/ProTable.vue'

export default {
  name: 'BackManage',
  data () {
    return {
      currentAccount: '',
      tableData: []
      // [{
      //   date: '2016-05-02',
      //   address: '0xD19bf94161282f94DA8d4e6530e093d1D017a4d5',
      //   identity: '生产阶段'
      // }]
    }
  },
  computed: {
  },
  components: {
    ProTable
  },
  beforeCreate: function () {
    Info.init().then(() => {
      Info.getIdentityArrLength().then((length) => {
        // length.c[0]---才能取到对应的长度；
        let len = length.c[0]
        for (let i = 0; i < len; i++) {
          Info.getParticipate(i).then((address) => {
            Info.getCurrIden(address).then((identity) => {
              let obj = {date: '2016-05-02'}
              obj.address = address
              obj.identity = identity
              this.tableData.push(obj)
            })
          })
        }
      })
    })
  },
  mounted () {
    this.currentAccount = window.web3.eth.coinbase
    // Info.getAllIdentity()
  },
  methods: {
  }
}
</script>

<style scoped>
#table{
  width:1235px;
  margin:0 auto;
}
.label{
  font-size:20px;
}

</style>
