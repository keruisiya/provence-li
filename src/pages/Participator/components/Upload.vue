<template>
  <keep-alive>
    <component :is='currentIdentity'></component>
  </keep-alive>
</template>

<script>
import Produce from './phase/Produce'
import Milking from './phase/Milking'
import Process from './phase/Process'
import StoreExpress from './phase/StoreExpress'
import Sell from './phase/Sell'

export default {
  name: 'Upload',
  data () {
    return {
      msg: '溯源信息上传'
    }
  },
  props: {
    currentAccount: {
      type: String,
      required: true
    },
    currentIdentity: {
      type: String,
      require: true
    }
  },
  components: {
    Produce,
    Milking,
    Process,
    StoreExpress,
    Sell
  },
  computed: {
  }
}
</script>

<style scoped>
</style>
