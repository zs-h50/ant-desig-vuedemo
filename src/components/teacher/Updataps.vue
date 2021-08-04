<template>
	<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmit">
		<a-form-item label="密码">
			<a-input v-decorator="['password', { rules: [{ required: true, message: '输入密码' }] }]"  placeholder="输入密码" />
		</a-form-item>
		<a-form-item :wrapper-col="{ span: 12, offset: 10 }">
			<a-button type="primary" html-type="submit">
				修改
			</a-button>
		</a-form-item>
	</a-form>
</template>

<script>
	import router from '@/router/index.js'
	import request from '@/utils/request.js'
	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this, {
					name: 'coordinated'
				}),
			};
		},
		methods: {
			handleSubmit(e) {
				e.preventDefault();
				const user = sessionStorage.getItem("user")
				const datas = JSON.parse(user)
				const account = datas.account;
				console.log(account);
				this.form.validateFields((err, values) => {
					if (!err) {
						console.log(values);
						const password = JSON.parse(JSON.stringify(values))
						request.post('/api/teacher/updats',{account,password})
						.then(res => {
							this.$message.success("密码修改成功！即将返回到登录界面")
							this.$router.push({
								path: '/'
							})
						})
						.catch(error =>{
							this.$message.success("密码修改失败")
							this.reload();
						})
					}
				});
			},
		},
	};
</script>
