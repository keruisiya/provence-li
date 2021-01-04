<template>
  <div class="content">
    <div class="content_input">
			<div class="title">
					<p>{{ msg }}</p>
			</div>
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
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="110px" class="demo-ruleForm">
        <el-form-item label="仓库地址代码" prop="storeAddr">
          <el-input v-model="ruleForm.storeAddr"> </el-input>
        </el-form-item>
        <el-form-item label="仓储操作员" prop="storeName">
          <el-input v-model="ruleForm.storeName"> </el-input>
        </el-form-item>
        <el-form-item label="入库时间" prop="storageTime">
          <el-input v-model="ruleForm.storageTime"> </el-input>
        </el-form-item>
        <el-form-item label="出库时间" prop="retirTime">
          <el-input v-model="ruleForm.retirTime"> </el-input>
        </el-form-item>
        <el-form-item label="承运人" prop="transName">
          <el-input v-model="ruleForm.transName"> </el-input>
        </el-form-item>
        <el-form-item label="运输单号" prop="transCode">
          <el-input v-model="ruleForm.transCode"> </el-input>
        </el-form-item>
        <el-form-item label="运输时间" prop="transTime">
          <el-input v-model="ruleForm.transTime"> </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')" style="float:left">上传</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
      <div class="divide">
				<el-divider><i class="el-icon-mobile-phone"></i></el-divider>
			</div>
			<el-steps :space="200" :active="applyStatus" finish-status="success" align-center>
				<el-step title="申请中"></el-step>
				<el-step title="审核中"></el-step>
				<el-step title="审核通过"></el-step>
			</el-steps>
    </div>
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
.content {
	width: 720px;
	height: 720px;
	box-sizing: border-box;
	padding: 0 50px;
	border-radius: 5px;
	box-shadow: 0px 2px 12px 0px rgba(105, 105, 105, 0.07);
	background: rgba(255, 255, 255, 0.5);
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	animation: mymove 1s ease-in-out  alternate;
	overflow: hidden;
	transition: 1.5s;
}
.content_input {
	width: 500px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.title {
	text-align: center;
	font-size: 24px;
	margin-bottom: 30px;
	font-weight: bold;
	color: #606266;
}
.divide{
	width:100%;
	margin:50px 0 36px 0;
	/* margin:20px auto; */
}

@keyframes mymove {
	0% {
		width: 0px;
		height: 5px;
	}

	10% {
		width: 50px;
		height: 5px;
	}

	15% {
		width: 100px;
		height: 5px;
	}

	20% {
		width: 150px;
		height: 5px;
	}

	25% {
		width: 200px;
		height: 5px;
	}

	30% {
		width: 250px;
		height: 5px;
	}

	35% {
		width: 300px;
		height: 5px;
	}

	40% {
		width: 350px;
		height: 5px;
	}

	45% {
		width: 450px;
		height: 5px;
	}

	50% {
		width: 500px;
		height: 5px;
	}

	55% {
		height: 30px;
	}

	60% {
		height: 60px;
	}

	65% {
		height: 90px;
	}

	70% {
		height: 120px;
	}

	75% {
		height: 150px;
	}

	80% {
		height: 180px;
	}

	85% {
		height: 210px;
	}

	90% {
		height: 240px;
	}

	95% {
		height: 240px;
	}

	100% {
		height: 300px;
	}
}
</style>