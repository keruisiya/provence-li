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
<template>
  <el-table
    ref="singleTable"
    style="width: 1235px"
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
      property="date"
      label="日期"
      width="120">
    </el-table-column>
    <el-table-column
      property="address"
      label="账户"
      width="390">
    </el-table-column>
    <el-table-column
      property="identity"
      label="参与阶段"
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
</template>
<style>
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
  export default {
    data () {
      return {
        search: ''
      }
    },
    props: {
      tableData: {
        type: Array,
        required: true
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

