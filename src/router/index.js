import Vue from 'vue'
import Router from 'vue-router'
import Participator from '@/pages/Participator/Participator.vue'
import BackMain from '@/pages/BackManage/BackMain.vue'
import Component from '@/pages/Testpage/component.vue'

import BasicIndex from '@/pages/BackManage/components/BasicIndex'
import AccountManage from '@/pages/BackManage/components/AccountManage'
import AccountConfirm from '@/pages/BackManage/components/AccountConfirm'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'participator',
      component: Participator
    }, {
      path: '/manage',
      name: 'BackMain',
      component: BackMain,
      redirect: to => {
        return '/manage/index'
      },
      children: [
        {
          path: '/manage/index',
          name: 'index',
          component: BasicIndex
        },
        {
          path: '/manage/AccountManage',
          name: 'AccountManage',
          component: AccountManage
        },
        {
          path: '/manage/AccountConfirm',
          name: 'AccountConfirm',
          component: AccountConfirm
        }
      ]
    }, {
      path: '/component',
      name: 'component',
      component: Component
    }
  ]
})
