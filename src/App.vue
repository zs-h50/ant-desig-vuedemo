<template>
	<div id="app">
		<a-config-provider :locale="locale">
			<router-view v-if="isRouterAlive" />
		</a-config-provider>
	</div>
</template>

<script>
	import zhCN from 'ant-design-vue/lib/locale-provider/zh_CN';
	export default {
		data() {
			return {
				locale: zhCN,
				isRouterAlive: true, //控制视图是否显示的变量
			}
		},
		provide() { //父组件中通过provide来提供变量，在子组件中通过inject来注入变量。                                             
			return {
				reload: this.reload
			}
		},
		methods: {
			reload() {
				this.isRouterAlive = false; //先关闭，
				this.$nextTick(function() {
					this.isRouterAlive = true; //再打开
				})
			}
		}
	}
</script>


<style>

</style>
