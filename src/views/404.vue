<template>
  <a-result status="403" title="403" sub-title="Sorry, you are not authorized to access this page.">
    <template #extra>
      <a-button type="primary" @click="come()">
        返回页面
      </a-button>
    </template>
  </a-result>
</template>
<script>
	import router from '@/src/router/index.js'
export default {
  data() {
    return {};
  },
  methods:{
	come(){
		this.$router.push({
			path:'/login'
		})
	}  
  }
};
</script>
