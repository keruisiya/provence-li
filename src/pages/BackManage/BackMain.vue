<template>
  <div id="app">
    <pro-header></pro-header>
    <el-container>
      <pro-navmenu :menu='menu' :collapse="collapse"></pro-navmenu>
      <el-main>
        <pro-tabs></pro-tabs>
        <keep-alive>
          <router-view/>
        </keep-alive>
      </el-main>
    </el-container>
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
        id: 'basic',
        sub: [{
          name: '账户一览',
          componentName: 'AccountManage'
        }, {
          name: '账户确认',
          componentName: 'AccountConfirm'
        }]
      }],
      collapse: false
    }
  }
}
</script>

<style>

</style>
