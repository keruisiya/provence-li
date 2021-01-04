<template>
  	<div class="content">
			<div class="content_input">
				<div class="title">
					<p>{{this.msg}}</p>
				</div>
				<el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" class="demo-ruleForm">
					<el-form-item label="账户地址" prop="address">
						<el-input v-model="ruleForm.address" style="width:369px;float:left"> </el-input>
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
          // **这里要用then要用箭头函数**
          Info.setIdentity(this.ruleForm.address, this.ruleForm.identity).then((res) => {
            console.log(res.logs)
            // 切换到审核通过状态，过两秒自动切换到上传数据界面（这是子组件，切换成upload得组件在participator中）
            this.applyStatus = 3
            this.$notify({
              title: '申请成功',
              message: '刷新页面或等待2s后跳转到溯源数据上传页面',
              type: 'success'
            })
          }, function (err) {
            // 可能有账户已经注册过的。----不会发生这种情况
            // 账户如果注册过是直接转换到数据上传得页面得
            console.log(err)
            this.$notify.error({
              title: '出现错误',
              message: '申请过程中出现了错误，请稍后重试'
            })
          })
        } else {
          this.$message.error('请确认是否所有信息输入完整！')
          return false
        }
      })
    },
    resetForm (formName) {
      this.$refs[formName].resetFields()
    },
    test1 () {
      Info.setProduceInfo('12', 'fad', 'a', 'adf', 'a', 'dfa', 'ad').then(function (res) {
        console.log(res)    // 这个输出的是交易
        console.log(res.logs)// 这里会返回相关值
        for (var i = 0; i < res.logs.length; i++) {
          var log = res.logs[i]
          if (log.event === 'ProduceDateAdded') {
            console.log('from:', log.args._ID.toNumber())
            // console.log('to:', log.args._to)
            // console.log('amount:', log.args._value.toNumber())
            break
          }
        }
      }, function (err) {
        console.log(err)
      })
    },
    test2 () {
      // 测试设置生产设信息的部分合约
      // Info.getproduceId(0).then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      // console.log(Info.instance.produceDateAdded)
      // Info.getProFromID(3788746011575487).then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })

      // Info.getProlength().then(function (res) {
      //   console.log(res)
      // }, function (err) {
      //   console.log(err)
      // })
      Info.getJson().then(function (res) {
        console.log(res)
      })
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
