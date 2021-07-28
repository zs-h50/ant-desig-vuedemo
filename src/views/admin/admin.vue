<template>
	<a-layout>
		<!-- 头部 -->
		<div id="header">
			<a-layout-header>
				<Header></Header>
			</a-layout-header>
		</div>
		<!-- 主体：包含导航菜单与内容 -->
		<div>
			<a-layout>
				<Middle></Middle>
			</a-layout>
		</div>
		<!-- 底部 -->
		<div>
			<a-layout-footer>
				<Footer />
			</a-layout-footer>
		</div>
	</a-layout>
</template>
<script>
	import Header from '@/components/Header.vue'
	import Footer from '@/components/Footer.vue'
	import Middle from '@/components/admin/Middle.vue'
	export default {
		data() {
			return {
				
			}
		},
		components: {
			Header,
			Footer,
			Middle,
		},
		
	}
</script>
