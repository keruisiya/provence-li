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
        <el-form-item label="产品ID" prop="commodityId">
          <el-input v-model="ruleForm.commodityId"> </el-input>
        </el-form-item>
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
  name: 'StoreExpress',
  data () {
    return {
      msg: '包装物流阶段信息上传',
      ruleForm: {
        commodityId: '',
        storeAddr: '',
        storeName: '',
        storageTime: '',
        retirTime: '',
        transName: '',
        transCode: '',
        transTime: ''
      },
      rules: {
        commodityId: [
          { required: true, message: '请输入相应信息', trigger: 'blur' }
        ],
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
      },
      applyStatus: 1

    }
  },
  computed: {
  },
  methods: {
    submitForm (formName) {
// 先判断 产品id 是否存在在链上
// if (Info.isIdExist()) {
//   this.$message({
//     message: '产品id未上链',
//     type: 'error'
//   })
//   return
// }
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.applyStatus = 2
          Info.setStoreExpressInfo(this.ruleForm.commodityId, this.ruleForm.storeAddr, this.ruleForm.storeName, this.ruleForm.storageTime, this.ruleForm.retirTime, this.ruleForm.transName, this.ruleForm.transCode, this.ruleForm.transTime).then((res) => {
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