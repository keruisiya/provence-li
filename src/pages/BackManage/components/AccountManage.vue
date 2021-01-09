<template>
<!--
日后扩展等等想法
      table的参数：
        :data===表格中的数据               -----------1
        border===表格外围的边框             ----------1
        stripe===带斑马纹路的 表格
        row-class-name====给表格 行 加颜色 ---'warning-row' -----------1
        height==== 可以起到固定表头的作用； ----------1
        max-height属性为 Table 指定最大高度。此时若表格所需的高度大于最大高度，则会显示一个滚动条。--------1
        highlight-current-row 配合 current-change事件 实现 单选操作
        加一个type =  selection  实现多选   --------1 
      table-column的参数：
        prop：表头的标识         -----------1
        label：表头的名称         ----------1
        width：宽度             ----------1
        fixed属性，它接受 Boolean 值或者leftright，表示左边固定还是右边固定。 ------1
        type=index 是帮助 形成索引号列的 -------------1 
        show-overflow-tooltip ----单行溢出隐藏 ----------1

        要加搜索功能

      slot-scope  可以使用 scope.row.name ---获取表格中每列的数据 data
      设置 type="expand" 和 Scoped slot 可以开启展开行功能 ----可以达到展开数据的效果
    -->
  <el-card class="boxCard">
    <div slot="header" class="clearfix">
      <span style="float:left">已注册账户</span>
    </div>
    <el-table
      ref="singleTable"
      :data="tableData.filter(data => !search || data.identity.toLowerCase().includes(search.toLowerCase()) || data.address.toLowerCase().includes(search.toLowerCase()))"
      :border="false"
      :header-cell-style="{textAlign: 'center'}"
      :cell-style="{ textAlign: 'center' }"
      :row-class-name="tableRowClassName"
      style="width:1290px"
      max-height="600px" 
      >
      <el-table-column
        type="selection"
        width="55">
      </el-table-column>
      <el-table-column
        type="index"
        label="序号"
        width="80">
      </el-table-column>
      <el-table-column
        property="date"
        label="申请日期"
        width="120">
      </el-table-column>
      <el-table-column
        property="address"
        label="账户地址"
        width="390">
      </el-table-column>
      <el-table-column
        property="identity"
        label="参与阶段"
        width="200"
      >
      </el-table-column>
      <el-table-column
        property="score"
        label="积分"
        width="200"
      >
      </el-table-column>
      <el-table-column
        align="center"
      >
        <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="medium"
            placeholder="输入关键字搜索"/>
        </template>
        <template slot-scope="scope">
          <el-button
            size="small"
            icon="el-icon-search"
            @click="handleLook(scope.$index, scope.row)"> 查看</el-button>
          <el-button
            size="small"
            type="danger"
            icon="el-icon-setting"
            @click="handleOption(scope.$index, scope.row)"> 操作</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>
<style>
#table{
  /* width:1235px;
  margin:0 auto; */
}
.label{
  font-size:20px;
}
.boxCard{
  margin: 0 20px 0 0;
  height:759px;
  min-width:1580px
}
.title {
	text-align: left;
	font-size: 18px;
  color: #303133;
  margin:0 0 10px 20px;
}

.el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }

  .el-table .keruisiya-row {
    background: #F0FFFF;
  }

</style>

<script>
import Info from '@/js/info'
const toChinese = {
  produce: '生产阶段',
  milking: '产奶阶段',
  process: '加工阶段',
  storeExpress: '存储物流阶段',
  sell: '销售阶段'
}

export default {
  name: 'AccountManage',
  data () {
    return {
      currentAccount: '',
      tableData: [],
      // [{
      //   date: '2016-05-02',
      //   address: '0xD19bf94161282f94DA8d4e6530e093d1D017a4d5',
      //   identity: '生产阶段'
      // }]
      search: ''
    }
  },
  computed: {
  },
  beforeCreate: function () {
    Info.init().then(() => {
      Info.getIdentityArrLength().then((len) => {
        for (let i = 0; i < len; i++) {
          Info.getParticipate(i).then((address) => {
            Info.vaildAccout(address).then((valid) => {
              if (valid) {
                let obj = {}
                Promise.all([Info.getCurrIden(address), Info.getApplyDate(address)]).then((res) => {
                  obj.address = address
                  obj.identity = toChinese[res[0]]
                  obj.score = '100'
                  obj.date = res[1]
                  this.tableData.push(obj)
                }).catch((err) => {
                  console.log(err)
                })
              } else {
                return
              }
            })
          })
        }
      })
    })
  },
  methods: {
    tableRowClassName ({row, rowIndex}) {
      if (rowIndex % 3 === 0) {
        return 'warning-row'
      } else if (rowIndex % 3 === 1) {
        return 'success-row'
      }
      return 'keruisiya-row'
    },
    handleLook (index, row) {
      console.log(index, row)
    },
    handleOption (index, row) {
      console.log(index, row)
    }
  }
}
</script>



