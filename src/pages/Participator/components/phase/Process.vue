<template>
  <div class="content">
    <div class="content_input">
			<div class="title">
					<p>{{ msg }}</p>
			</div>
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
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="120px" class="demo-ruleForm">
				<el-form-item label="milk编号" prop="milkId">
          <el-input v-model="ruleForm.milkId"> </el-input>
        </el-form-item>
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
        <el-form-item label="加工工艺" prop="equiSkil">
          <el-input v-model="ruleForm.equiSkil"> </el-input>
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
				<el-step title="上传中"></el-step>
				<el-step title="上传确认"></el-step>
				<el-step title="已上传"></el-step>
			</el-steps>
			<div class="link">
        <el-link type="primary" :underline="false" href="/#/custom">已有产品ID？去查询</el-link>
      </div>
    </div>
  </div>
</template>

<script>
import Info from '@/js/info'

export default {
  name: 'Process',
  data () {
    return {
      msg: '加工阶段信息上传',
      ruleForm: {
        milkId: '',
        processAddr: '',
        processName: '',
        processTime: '',
        balingAddr: '',
        balingName: '',
        equiSkil: ''
      },
      rules: {
        milkId: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
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
      },
      applyStatus: 1
    }
  },
  computed: {
  },
  methods: {
    submitForm (formName) {
// 先判断 milkid 是否存在在链上
// if (Info.isIdExist()) {
//   this.$message({
//     message: '产奶阶段id未上链',
//     type: 'error'
//   })
//   return
// }
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.applyStatus = 2
          Info.setProcessInfo(this.ruleForm.milkId, this.ruleForm.processAddr, this.ruleForm.processName, this.ruleForm.processTime, this.ruleForm.balingAddr, this.ruleForm.balingName, this.ruleForm.equiSkil).then((res) => {
            console.log(res)
            this.applyStatus = 3
            this.$notify({
              title: '上传成功',
              message: '',
              type: 'success'
            })
            // 可以捕获事件
          }).catch((err) => {
// 为了防止 签名未确认等其他情况。
            console.log(err)
            this.$notify.error({
              title: '出现错误',
              message: '签名未确认或上传过程中出现了错误，请重试'
            })
          })
        }
      })
    },
    resetForm (formName) {
      this.$refs[formName].resetFields()
      this.applyStatus = 1
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

.link{
  width: 360px;
  margin: 20px auto;
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