<template>		
  <div>
    <div class="content">
      <div class="content_input">
        <div class="title">
            <p>溯源信息查询</p>
        </div>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-suffix=":" label-width="100px" :inline="true"  >
          <el-form-item label="产品ID" prop="commodityId">
            <el-input v-model="ruleForm.commodityId" placeholder="请输入产品ID"> </el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="submitForm('ruleForm')">查询</el-button>
          </el-form-item>
        </el-form>
        <div class="divide">
					<el-divider><i class="el-icon-mobile-phone"></i></el-divider>
				</div>
        <div class="link">
          <el-link type="primary" :underline="false" style="float:left" @click="linkPaticipate">申请参与</el-link>
          <el-link type="primary" :underline="false" style="float:right">有疑问？去申诉</el-link>
        </div>
      </div>
    </div>
    <el-dialog title="溯源数据展示" :visible.sync="dialogTableVisible">
      <el-collapse v-model="activeNames" @change="handleChange">
        <el-collapse-item title="生产阶段" name="1">
          <el-table :data="proData">
            <el-table-column property="date" label="日期" width="150"></el-table-column>
            <el-table-column property="address" label="账户地址" width="200"></el-table-column>
            <el-table-column property="farmsID" label="养殖场名称"></el-table-column>
            <el-table-column property="farmsName" label="养殖厂地址"></el-table-column>
            <el-table-column property="farmsAdd" label="奶牛品种"></el-table-column>
            <el-table-column property="cowVar" label="奶牛来源"></el-table-column>
            <el-table-column property="cowSource" label="养殖饲料"></el-table-column>
            <el-table-column property="feedName" label="饲料喂养人"></el-table-column>
          </el-table>
        </el-collapse-item>
        <el-collapse-item title="milk阶段" name="2">
          <el-table :data="tableData">
            <el-table-column property="date" label="日期" width="150"></el-table-column>
            <el-table-column property="address" label="账户地址" width="200"></el-table-column>
            <el-table-column property="provenData" label="溯源数据"></el-table-column>
          </el-table>
        </el-collapse-item>
        <el-collapse-item title="加工阶段" name="3">
          <el-table :data="tableData">
            <el-table-column property="date" label="日期" width="150"></el-table-column>
            <el-table-column property="address" label="账户地址" width="200"></el-table-column>
            <el-table-column property="provenData" label="溯源数据"></el-table-column>
          </el-table>
        </el-collapse-item>
        <el-collapse-item title="存储物流阶段" name="4">
          <el-table :data="tableData">
            <el-table-column property="date" label="日期" width="150"></el-table-column>
            <el-table-column property="address" label="账户地址" width="200"></el-table-column>
            <el-table-column property="provenData" label="溯源数据"></el-table-column>
          </el-table>
        </el-collapse-item>
        <el-collapse-item title="销售阶段" name="5">
          <el-table :data="tableData">
            <el-table-column property="date" label="日期" width="150"></el-table-column>
            <el-table-column property="address" label="账户地址" width="200"></el-table-column>
            <el-table-column property="provenData" label="溯源数据"></el-table-column>
          </el-table>
        </el-collapse-item>
      </el-collapse>
    </el-dialog>
  </div>
	
  

</template>

<script>
import Info from '@/js/info'
export default {
  name: 'Custom',
  data () {
    return {
      ruleForm: {
        commodityId: ''
      },
      rules: {
        commodityId: [
          { required: true, message: '请输入商品ID', trigger: 'blur' },
          { min: 15, max: 15, message: '请确认位数是否输入正确', trigger: 'blur' },
          {
            required: true,
            pattern: /([0-9]){15}$/,
            message: '请输入符合规范的商品ID',
            trigger: 'blur'
          }
        ]
      },
      tableData: [{
        date: '2016-05-02',
        address: '王小虎',
        provenData: '上海市普陀区金沙江路 1518 弄'
      }],
      proData: [],
      dialogTableVisible: false,
      activeNames: ['1']
    }
  },
  beforeCreate: function () {
    Info.init().then(() => {})
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        let json = {}
        if (valid) {
          let id = this.ruleForm.commodityId
          let milkId = id.slice(5)
          let produceId = id.slice(10)
          Promise.all([Info.getProFromID(produceId), Info.getMilkFromID(milkId), Info.getProcessFromID(id), Info.getStoreExpressFromID(id), Info.getSellFromID(id)]).then((res) => {
            // res是一个所有的结果数组
            let _prodata = Object.assign(JSON.parse(res[0]), {date: '2020-12-25', address: '0x1231231231'})
            console.log(_prodata)
            this.proData = []
            this.proData.push(_prodata)
            json.milkJson = JSON.parse(res[1])
            json.processJson = JSON.parse(res[2])
            json.storeExpressJson = JSON.parse(res[3])
            json.sellJson = JSON.parse(res[4])
            console.log(json)
            // this.tableData = json
            this.dialogTableVisible = true
          }).catch((error) => {
            console.log(error)
            this.$notify.error({
              title: '出现错误',
              message: '未找到匹配的溯源信息，请确认产品ID是否输入正确'
            })
            this.$message({
              message: '未找到匹配的溯源信息，请确认产品ID是否输入正确',
              type: 'error'
            })
          })
        }
      })
    },
    handleChange (val) {
      console.log(val)
    },
    linkPaticipate () {
      // 应该有一个注册以太坊账户的页面，由以太坊注册完成后，跳转到完成页面
      // this.$router.push('/')
      console.log(1111111)
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
.link{
  width: 360px;
  margin: 0 auto;
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
.el-input {
  width: 280px;
}

</style>