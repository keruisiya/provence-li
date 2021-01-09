<template>
  <div class="content">
		<div class="content_input">
			<div class="title">
				<p>{{this.msg}}</p>
			</div>
			<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
				<el-form-item label="账户地址" prop="address">
					<el-input v-model="ruleForm.address" style="width:369px;float:left" placeholder="请输入账户地址"> </el-input>
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
			<div class="divide">
				<el-divider><i class="el-icon-mobile-phone"></i></el-divider>
			</div>
			<el-steps :space="200" :active="applyStatus" finish-status="success" align-center>
				<el-step title="申请中"></el-step>
				<el-step title="审核中"></el-step>
				<el-step title="审核通过"></el-step>
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
          return time.getTime() <= Date.now()
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
// **这里要用then要用箭头函数**
          Info.setIdentity(this.ruleForm.address, this.ruleForm.identity, this.ruleForm.date).then((res) => {
            console.log(res)
            this.applyStatus = 2
            this.$notify({
              title: '申请成功',
              message: '等待管理节点批准',
              type: 'success'
            })
          }).catch((err) => {
            if (err.message === 'WalletMiddleware - Invalid "from" address.') {
              this.$notify.error({
                title: '出现错误',
                message: '您不能为他人账户签名，请重试'
              })
            } else {
// 这个不是捕获 可能有账户已经注册过的 合约上的 require 。
// 因为 账户如果注册过是直接转换到数据上传得页面得
// 而是为了防止 签名未确认等其他情况。
              console.log(err)
              this.$notify.error({
                title: '出现错误',
                message: '签名未确认申请过程中出现了错误，请重试'
              })
            }
          })
        }
      })
    },
    resetForm (formName) {
      // console.log(typeof this.ruleForm.date) // 是一个string类型的--
      this.$refs[formName].resetFields()
      this.applyStatus = 1
    }
  }
}
</script>

<style scoped>
.content {
	width: 680px;
	height: 520px;
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
		width: 70px;
		height: 5px;
	}

	15% {
		width: 140px;
		height: 5px;
	}

	20% {
		width: 210px;
		height: 5px;
	}

	25% {
		width: 280px;
		height: 5px;
	}

	30% {
		width: 350px;
		height: 5px;
	}

	35% {
		width: 420px;
		height: 5px;
	}

	40% {
		width: 490px;
		height: 5px;
	}

	45% {
		width: 560px;
		height: 5px;
	}

	50% {
		width: 680px;
		height: 5px;
	}

	55% {
    width:680px;
		height: 50px;
	}

	60% {
		height: 100px;
	}

	65% {
		height: 150px;
	}

	70% {
		height: 200px;
	}

	75% {
		height: 250px;
	}

	80% {
		height: 300px;
	}

	85% {
		height: 350px;
	}

	90% {
		height: 400px;
	}

	95% {
		height: 450px;
	}

	100% {
		height: 500px;
	}
}
</style>
