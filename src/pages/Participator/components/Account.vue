<template>
  <div>
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
      <el-form-item label="申请日期" prop="date" >
        <el-date-picker
          style="float:left"
          v-model="ruleForm.date"
          align="right"
          type="date"
          placeholder="选择日期"
          format="yyyy-MM-dd"
          value-format="yyyy-MM-dd"
          :picker-options="pickerOptions">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')" style="float:left">申请</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
    <el-divider><i class="el-icon-mobile-phone"></i></el-divider>
    <el-steps :space="200" :active="applyStatus" finish-status="success" align-center style="margin-left:-50px">
      <el-step title="申请中"></el-step>
      <el-step title="审核中"></el-step>
      <el-step title="审核通过"></el-step>
    </el-steps>    
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
        identity: '',
        date: ''
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
        ],
        date: [
          { required: true, message: '请选择申请日期', trigger: 'change' }
        ]
      },
      // 设置日期选择器不可以选中的 日子
      pickerOptions: {
        disabledDate (time) {
          return time.getTime() < Date.now()
        }
      },
      applyStatus: 1
    }
  },
  computed: {
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$message({
            message: '账户身份提交成功，等待审核',
            type: 'success'
          })
          this.applyStatus = 2
          Info.setIdentity(this.ruleForm.address, this.ruleForm.identity).then(function (res) {
            console.log(res)
          }, function (err) {
            // 可能有账户已经注册过的。----不会发生这种情况
            console.log(err)
          })
        } else {
          this.$message.error('请确认是否所有信息输入完整！')
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
</style>
