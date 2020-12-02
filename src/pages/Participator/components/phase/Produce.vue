<template>
  <div>
    <h1>{{ msg }}</h1>
    <!-- 
      // 养殖场代号id
        string farmsID;
        // 养殖场名称；
        string farmsName;
        // 养殖厂地址；
        string farmsAdd;
        // 奶牛品种；
        string cowVar;
        // 奶牛来源
        string cowSource;
        // 养殖饲料；
        string feedAqu;
        // 饲料喂养人；
        string feedName;
     -->
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
      <el-form-item label="养殖场代号" prop="farmsID">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="养殖场名称" prop="farmsName">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="养殖厂地址" prop="farmsAdd">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="奶牛品种" prop="cowVar">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="奶牛来源" prop="cowSource">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="养殖饲料" prop="feedAqu">
        <el-input v-model="ruleForm.farmsID"> </el-input>
      </el-form-item>
      <el-form-item label="饲料喂养人" prop="feedName">
        <el-input v-model="ruleForm.farmsID"> </el-input>
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
  name: 'Upload',
  data () {
    return {
      msg: '生产阶段信息上传',
      ruleForm: {
        farmsID: '',
        farmsName: '',
        farmsAdd: '',
        cowVar: '',
        cowSource: '',
        feedAqu: '',
        feedName: ''
      },
      rules: {
        farmsID: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        farmsName: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        farmsAdd: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        cowVar: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        cowSource: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        feedAqu: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
        feedName: [
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
            message: '上传成功，等待审核',
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
