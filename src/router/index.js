import Vue from 'vue'
import Router from 'vue-router'
// import Dashboard from '@/components/Dashboard'
// import Signup from '@/components/Signup'
import Account from '@/pages/Account/Account.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'account',
      component: Account
    }
  ]
})
