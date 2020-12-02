<template>
  <div>
    <h1>{{ msg }}</h1>
    <!-- 
    // 销售单号
        string sellCode;
        // 销售员
        string sellName;
        // 销售日期
        string sellTime;
        // 销售地址
        string sellAddr;
        // 保质期
        string produDate;
  -->
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="挤奶地址编号" prop="sellCode">
        <el-input v-model="ruleForm.sellCode"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶员" prop="sellName">
        <el-input v-model="ruleForm.sellName"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶卫生情况" prop="sellTime">
        <el-input v-model="ruleForm.sellTime"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="sellAddr">
        <el-input v-model="ruleForm.sellAddr"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="produDate">
        <el-input v-model="ruleForm.produDate"> </el-input>
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
  name: 'Sell',
  data () {
    return {
    // 挤奶地址编号
    // string milkingAddrCode;
     // 挤奶员；
     // string milkingUser;
     // 挤奶卫生情况
     // string milkingEnv;
     // 挤奶时间
     // string milkingTime;
      msg: '销售阶段信息上传',
      ruleForm: {
        sellCode: '',
        sellName: '',
        sellTime: '',
        sellAddr: '',
        produDate: ''
      },
      rules: {
        sellCode: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        sellName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        sellTime: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        sellAddr: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        produDate: [
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