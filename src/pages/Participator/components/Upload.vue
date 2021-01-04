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
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$message({
            message: '上传成功，等待审核',
            type: 'success'
          })
        } else {
          this.$message.error('请确认是否所有信息输入完整！')
          return false
        }
        // 后续的操作；
      })
    },
    resetForm (formName) {
      this.$refs[formName].resetFields()
    }
  }
}
</script>

<style scoped>
</style>
