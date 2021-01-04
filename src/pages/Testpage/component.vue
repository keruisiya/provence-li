<template>		
	<div class="content">
		<div class="content_input">
			<div class="title">
					<p>参与者信息上传</p>
			</div>
			<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
				<el-form-item label="养殖场代号" prop="farmsID">
					<el-input v-model="ruleForm.farmsID"> </el-input>
				</el-form-item>
				<el-form-item label="养殖场名称" prop="farmsName">
					<el-input v-model="ruleForm.farmsName"> </el-input>
				</el-form-item>
				<el-form-item label="养殖厂地址" prop="farmsAdd">
					<el-input v-model="ruleForm.farmsAdd"> </el-input>
				</el-form-item>
				<el-form-item label="奶牛品种" prop="cowVar">
					<el-input v-model="ruleForm.cowVar"> </el-input>
				</el-form-item>
				<el-form-item label="奶牛来源" prop="cowSource">
					<el-input v-model="ruleForm.cowSource"> </el-input>
				</el-form-item>
				<el-form-item label="养殖饲料" prop="feedAqu">
					<el-input v-model="ruleForm.feedAqu"> </el-input>
				</el-form-item>
				<el-form-item label="饲料喂养人" prop="feedName">
					<el-input v-model="ruleForm.feedName"> </el-input>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="submitForm('ruleForm')" style="float:left">上传</el-button>
					<el-button @click="resetForm('ruleForm')">重置</el-button>
				</el-form-item>
			</el-form>
		</div>
  </div>

</template>

<script>
	import '../../../ribbon.js'
export default {

  data () {
    return {
      UserName: '',
      PassWord: '',
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
      }
    }
  }
}
</script>

<style scoped>

.content {
	width: 700px;
	height: 600px;
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