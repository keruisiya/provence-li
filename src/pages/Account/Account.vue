<template>
  <div id="account">
    <h1>{{ msg }}</h1>
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="账户地址" prop="address">
        <el-input v-model="ruleForm.address"> </el-input>
      </el-form-item>
      <el-form-item label="参与阶段" prop="identity" >
        <el-select v-model="ruleForm.identity" placeholder="请选择对应参与阶段" style="float:left">
          <el-option label="生产阶段" value="produce"></el-option>
          <el-option label="挤奶阶段" value="milking"></el-option>
          <el-option label="加工阶段" value="process"></el-option>
          <el-option label="存储物流阶段" value="storeExpress"></el-option>
          <el-option label="销售阶段" value="sell"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')" style="float:left">申请</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>

    <hr/>
    <div>
      当前账户地址：{{ currentAccount }}
    </div>
  </div>
</template>

<script>
import Info from '@/js/info'

export default {
  name: 'account',
  data () {
    return {
      msg: '账户的身份设定',
      ruleForm: {
        address: '',
        identity: ''
      },
      rules: {
        address: [
          { required: true, message: '请输入地址信息', trigger: 'blur' },
          { min: 42, max: 42, message: '请确认位数是否输入正确', trigger: 'blur' },
          {
            required: true,
            pattern: /^0x([0-9]|[A-F]|[a-f]){40}$/,
            message: '请输入正确的以太坊地址',
            trigger: 'blur'
          }
        ],
        identity: [
          { required: true, message: '请选择对应参与阶段', trigger: 'change' }
        ]
      },
      currentAccount: '12121'
    }
  },
  computed: {
  },
  beforeCreate: function () {
    console.log(window.web3.eth.accounts[9])
    Info.init()
  },
  mounted () {
    this.currentAccount = window.web3.eth.coinbase

    // this.currentAccount = window.metamask.eth.coinbase
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          Info.setIdentity(this.ruleForm.address, this.ruleForm.identity).then(function (res) {
            console.log(res)
          }, function (err) {
            console.log(err)
          })
          // window.web3.eth.coinbase.send
          // alert('submit!')
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    resetForm (formName) {
      this.$refs[formName].resetFields()
    }
  }
}
</script>

<style scoped>
#account{
  width: 500px;
  margin:0 auto;
}
.label{
  font-size:20px;
}

</style>
