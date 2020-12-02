<template>
  <div>
    <h1>{{ msg }}</h1>
    <!-- 
     // 仓库地址代码
        string storeAddr;
        // 仓储操作员
        string storeName;
        // 入库时间
        string storageTime;
        // 出库时间
        string retirTime;
        // 承运人
        string transName;
        // // 运输单号
        string transCode;
        // // 运输时间
        string transTime;
  -->
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="挤奶地址编号" prop="storeAddr">
        <el-input v-model="ruleForm.storeAddr"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶员" prop="storeName">
        <el-input v-model="ruleForm.storeName"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶卫生情况" prop="storageTime">
        <el-input v-model="ruleForm.storageTime"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="retirTime">
        <el-input v-model="ruleForm.retirTime"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="transName">
        <el-input v-model="ruleForm.transName"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="transCode">
        <el-input v-model="ruleForm.transCode"> </el-input>
      </el-form-item>
      <el-form-item label="挤奶时间" prop="transTime">
        <el-input v-model="ruleForm.transTime"> </el-input>
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
  name: 'StoreExpress',
  data () {
    return {
      msg: '包装物流阶段信息上传',
      ruleForm: {
        storeAddr: '',
        storeName: '',
        storageTime: '',
        retirTime: '',
        transName: '',
        transCode: '',
        transTime: ''
      },
      rules: {
        storeAddr: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        storeName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        storageTime: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        retirTime: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        transName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        transCode: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        transTime: [
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