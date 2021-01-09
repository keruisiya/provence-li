<template>
  <div id="app">
    <pro-header></pro-header>
    <keep-alive>
      <el-container>
      <pro-navmenu :menu='menu' :collapse="collapse"></pro-navmenu>
      <el-main>
        <pro-tabs></pro-tabs>
        <!-- <keep-alive> -->
          <router-view/>
        <!-- </keep-alive> -->
      </el-main>
    </el-container>

    </keep-alive>
    
  </div>
</template>

<script>
import ProNavmenu from '@/components/ProNavmenu'
import ProHeader from '@/components/ProHeader'
import ProTabs from '@/components/ProTabs'

export default {
  name: 'BackMain',
  components: {
    ProNavmenu,
    ProHeader,
    ProTabs
  },
  data () {
    return {
      // 定义的 侧边栏内容
      menu: [{
        name: '账户管理',
        id: 'account',
        sub: [{
          name: '账户一览',
          componentName: 'AccountManage'
        }, {
          name: '账户确认',
          componentName: 'AccountConfirm'
        }]
      }, {
        name: '数据管理',
        id: 'data',
        sub: [{
          name: '数据一览',
          componentName: 'DataManage'
        }]
      }],
      collapse: false
    }
  }
}
</script>

<style>

</style>
