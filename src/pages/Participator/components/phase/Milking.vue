<template>
  <div>
    <h1>{{ msg }}</h1>
    <!-- 
    // 挤奶地址编号
     string milkingAddrCode;
     // 挤奶员；
     string milkingUser;
     // 挤奶卫生情况
     string milkingEnv;
     // 挤奶时间
     string milkingTime;
  -->
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="挤奶地址编号" prop="milkingAddrCode">
        <el-input v-model="ruleForm.milkingAddrCode"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶员" prop="milkingUser">
        <el-input v-model="ruleForm.milkingUser"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶卫生情况" prop="milkingEnv">
        <el-input v-model="ruleForm.milkingEnv"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="milkingTime">
        <el-input v-model="ruleForm.milkingTime"> </el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')" style="float:left">上传</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>

export default {
  name: 'Milking',
  data () {
    return {
      msg: '挤奶阶段信息上传',
      ruleForm: {
        milkingAddrCode: '',
        milkingUser: '',
        milkingEnv: '',
        milkingTime: ''
      },
      rules: {
        milkingAddrCode: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        milkingUser: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        milkingEnv: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        milkingTime: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$message({
            message: '数据上传成功，等待审核',
            type: 'success'
          })
        } else {
          this.$message.error('请确认是否所有信息输入完整！')
          return false
        }
        // 后续的操作；
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