<!--本页为左侧下拉菜单-->
<template>
  <el-aside ref='aside' >
    <el-row class="tac">
      <el-col :span="24">
        <el-menu
          default-active=""
          class="el-menu-vertical-demo"
          background-color="#3A3D4C"
          text-color="#fff"
          unique-opened
          router
          active-text-color="#fff"
          style="overflow:auto;height:905px"
          :collapse="collapse"
        >
          <el-menu-item index="index" @click="clickMenu('index')" align="left">
            <i class="el-icon-star-on"></i>
            <span slot="title">系统介绍</span>
          </el-menu-item>
          <el-submenu
            v-for="item of menu"
            :index="item.id"
            :key="item.id"
            align="left"
          >
            <template slot="title">
              <i class="el-icon-location"></i>
              <span>{{item.name}}</span>
            </template>
            <el-menu-item-group class="over-hide">
              <el-menu-item
                v-for="sub of item.sub"
                :index="sub.componentName"
                :key="sub.componentName"
                @click="clickMenu(sub.componentName)"
              >
                {{sub.name}}
              </el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
        <el-menu  
          class="el-menu-vertical-demo"
          background-color="#3A3D4C"
          text-color="#fff"
          unique-opened
          active-text-color="#fff"
          :collapse="collapse">
          <el-menu-item index="3" @click="clickButton" align="center">
            <i class="el-icon-d-arrow-right" v-if="collapse"></i>
            <i class="el-icon-d-arrow-left" v-else></i>
          </el-menu-item>
        </el-menu>
      </el-col>
    </el-row>
  </el-aside>
</template>

<script>
export default {
  name: 'navMenu',
  props: {
    menu: {
      type: Array,
      required: true
    },
    collapse: {
      type: Boolean,
      required: true
    }
  },
  methods: {
    clickMenu (componentName) {
      this.openedTab = this.$store.state.openedTab
      // tabNum 为当前点击的列表项在openedTab中的index，若不存在则为-1
      let tabNum = this.openedTab.indexOf(componentName)
      console.log(tabNum)
      console.log(this.openedTab)
      console.log(this.$store.state.openedTab)
      if (tabNum === -1) {
        // 该标签当前没有打开
        // 将componentName加入到已打开标签页state.openedTab数组中
        this.$store.commit('addTab', componentName)
      } else {
        // 该标签是已经打开过的，需要激活此标签页
        this.$store.commit('changeTab', componentName)
      }
    },
    clickButton () {
      this.collapse = !this.collapse
    }
  },
  data () {
    return {
      // menu: menu,
      // collapse: true
      openedTab: []
    }
  },
  mounted () {
    if (this.collapse) {
      this.$refs.aside.width = '80px'
    } else {
      this.$refs.aside.width = '200px'
    }
  },
  watch: {
    collapse (newStatus) {
      if (newStatus === true) {
        this.$refs.aside.width = '80px'
      } else {
        this.$refs.aside.width = '200px'
      }
    }
  }
}
</script>

<style scoped>
  .tac{
    height:800px;

  }
  .over-hide{
    overflow-x:hidden;
  }
  .el-submenu__title{
    border-bottom:1px solid #8d98a2
  }
  #button{
    line-height:60px;
    width:64px;
    background-color:#3A3D4C;
    color:white;
    border-top:0.5px solid white
  }
</style>
