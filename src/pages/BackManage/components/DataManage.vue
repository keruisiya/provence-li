<template>
  <div id="table">
    <el-table
      ref="singleTable"
      style="width: 1500px"
      :data="tableData.filter(data => !search || data.identity.toLowerCase().includes(search.toLowerCase()) || data.address.toLowerCase().includes(search.toLowerCase()))"
      :border="false"
      :row-class-name="tableRowClassName"
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
        property="identity"
        label="参与阶段"
        width="200"
      >
      </el-table-column>
      <el-table-column
        property="address"
        label="账户"
        width="390">
      </el-table-column>
      <el-table-column
        property="date"
        label="日期"
        width="120">
      </el-table-column>
      <el-table-column
        property="provenData"
        label="详细数据"
        width="200">
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
  </div>
</template>

<script>
export default {
  name: 'DataManage',
  data () {
    return {
      search: '',
      tableData: [{
        date: '2016-05-02',
        address: '0xD19bf94161282f94DA8d4e6530e093d1D017a4d5',
        identity: '生产阶段',
        provenData: '上传时间录入，前端直接导入，不要表单----后台展示 ---------------------------------需要改动合约'
      }]
    }
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

<style scoped>
  #table{
    width: 1600px;
    margin:0 auto
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