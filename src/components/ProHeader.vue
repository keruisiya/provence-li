<template>
  <el-header class="header" height="80px">
    <el-row>
      <el-col :span="12">
        <div style="float:left">
          <h4 id='name'>{{name}}</h4>
          <h5 id='engname'>{{engName}}</h5>
        </div>
      </el-col>
      <el-col :span="12">
        <div id="account">
          欢迎您！{{account}}
          <i class="el-icon-caret-bottom" v-popover:popover>&nbsp</i>
          <el-popover
            ref="popover"
            placement="bottom"
            title="所有权信息，信誉积分"
            width="200"
            trigger="hover"
            content="待完善，所有权转让功能可以放在这里">
          </el-popover>
          <!-- <el-avatar :size="38" src="https://empty" @error="errorHandler">
            <img src="https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png"/>
          </el-avatar> -->
          <!-- 看看能不能加载metamask的账户图片 ？？？？-->
          <el-avatar icon="el-icon-user-solid" :size="35" @error="errorHandler"></el-avatar>
        </div>
        <div id="icon">
          <i class="iconfont icon-iconset0336" @click="drawer = true"></i>
          <i class="iconfont icon-pifu"></i>
          <i class="iconfont icon-tanhao"></i>
          <i class="iconfont icon-anjianfengexian"></i>
        </div>
      </el-col>
    </el-row>
    <el-drawer
      title="我是标题"
      :visible.sync="drawer"
      :with-header="false">
      <span>我来啦!</span>
    </el-drawer>
  </el-header>
</template>

<script>
export default {
  name: 'navHeader',
  data () {
    return {
      name: '溯源后台管理系统',
      engName: 'Traceability management system',
      account: '管理员',
      drawer: false
    }
  },
  methods: {
    errorHandler () {
      return true
    }
  }
}
</script>

<style scoped>
  .header{
    /* background: #409EFF; */
    background: #01A5A7;
    line-height: 80px;
    color:white;
  }
  #name{
    margin-top:5px;
    font-size:26px;
    letter-spacing: 6px;
    line-height: 50px;
  }
  #engname{
    font-family: "Arial";
    line-height: 20px;
    font-size:17px;
  }
  .iconfont{
    font-size: 20px;
    margin-right: 10px;
  }
  #account{
    float:right;
    width:200px;
    height:80px;
    /* line-height:80px; */
  }
  #icon{
    float:right;
    height:80px;
  }
  .icon-anjianfengexian{
    margin-right:0
  }
  .el-avatar{
    vertical-align: middle;
  }
</style>
