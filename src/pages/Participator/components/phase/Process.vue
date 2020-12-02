<template>
  <div>
    <h1>{{ msg }}</h1>
    <!-- 
    // 加工地址代号
        string processAddr;
        // 加工员
        string processName;
        // 加工时间
        string processTime;
        // 包装地址代号
        string balingAddr;
        // 包装员
        string balingName;
        // 加工工艺和设备
        string equiSkil;
    -->
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="加工地址代号" prop="processAddr">
        <el-input v-model="ruleForm.processAddr"> </el-input>
      </el-form-item>
      <el-form-item label="加工员" prop="processName">
        <el-input v-model="ruleForm.processName"> </el-input>
      </el-form-item>
      <el-form-item label="加工时间" prop="processTime">
        <el-input v-model="ruleForm.processTime"> </el-input>
      </el-form-item>
      <el-form-item label="包装地址代号" prop="balingAddr">
        <el-input v-model="ruleForm.balingAddr"> </el-input>
      </el-form-item>
      <el-form-item label="包装员" prop="balingName">
        <el-input v-model="ruleForm.balingName"> </el-input>
      </el-form-item>
      <el-form-item label="加工工艺和设备" prop="equiSkil">
        <el-input v-model="ruleForm.equiSkil"> </el-input>
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
  name: 'Process',
  data () {
    return {
      msg: '加工阶段信息上传',
      ruleForm: {
        processAddr: '',
        processName: '',
        processTime: '',
        balingAddr: '',
        balingName: '',
        equiSkil: ''
      },
      rules: {
        processAddr: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        processName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        processTime: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        balingAddr: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        balingName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        equiSkil: [
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