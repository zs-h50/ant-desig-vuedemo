<template>
	<div style="padding:15px 15px 15px 75px;text-align: center;font-size: 20px;">
		<h1>欢迎 {{username.account}}使用系统</h1>
		<span>当前时间：{{currentTime}}</span>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				timer: '', //定义一个定时器的变量
				currentTime: new Date(), //获取当前时间
				username:'',
			}
		},
		created() {
			var vm = this;
			vm.timer = setInterval(() => {
				var y = new Date().getFullYear();
				var m = vm.appendZero(new Date().getMonth() + 1);
				var d = vm.appendZero(new Date().getDate());
				var ho = vm.appendZero(new Date().getHours());
				var mi = vm.appendZero(new Date().getMinutes());
				var se = vm.appendZero(new Date().getSeconds())
				//修改数据
				vm.currentTime = y + "-" + m + "-" + d + " " + ho + ":" + mi+":"+se;
			}, 1000)
		},
		methods: {
			appendZero(obj) {
				if (obj < 10) {
					return "0" + obj;
				} else {
					return obj;
				}
			}
		},
		beforeDestroy() {
			if (this.timer) {
				clearInterval(this.timer); // 在Vue实例销毁前，清除我们的定时器
			}
		},
		mounted() {
			
			const user = sessionStorage.getItem("user");
			this.username = JSON.parse(user);
		}
	}
</script>

<style>
</style>
