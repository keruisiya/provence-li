import Vue from 'vue'
import Router from 'vue-router'
// import Dashboard from '@/components/Dashboard'
// import Signup from '@/components/Signup'
import Participator from '@/pages/Participator/Participator.vue'
import BackManage from '@/pages/BackManage/BackManage.vue'
import Component from '@/pages/Testpage/component.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'participator',
      component: Participator
    }, {
      path: '/manage',
      name: 'BackManage',
      component: BackManage
    }, {
      path: '/component',
      name: 'component',
      component: Component
    }
  ]
})
