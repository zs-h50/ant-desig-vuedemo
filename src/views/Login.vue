<template>
	<div class="body">
		<TSCarousel />
		<div class="conbox">
			<a-form id="components-form-demo-normal-login" :form="form" class="login-form" @submit="handleSubmit">
				<!-- required: true开启校验 -->
				<h2 class="logintitle">用户登录</h2>
				<a-form-item>
					<a-input v-decorator="[
				        'account',
				        { rules: [{ required: true, message: '用户名不能为空' }] },
				      ]" placeholder="用户名">
						<a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)" />
					</a-input>
				</a-form-item>
				<a-form-item>
					<a-input v-decorator="[
				        'password',
				        { rules: [{ required: true, message: '密码不能为空' }] },
				      ]" type="password" placeholder="密码">
						<a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)" />
					</a-input>
				</a-form-item>

				<a-form-item>
					<div v-decorator="[
				        'identity',
				        { rules: [{ required: true, message: '请选择用户选项！' }] },
				      ]" type="radio">
						<a-radio-group>
							<a-radio value="0">管理员</a-radio>
							<a-radio value="1">学生</a-radio>
							<a-radio value="2">老师</a-radio>
						</a-radio-group>
					</div>
				</a-form-item>

				<a-form-item>
					<a-checkbox v-decorator="[
				        'remember',
				        {
				          valuePropName: 'checked',
				          initialValue: true,
				        },
				      ]">
						记住我
					</a-checkbox>
<!-- 					<a class="login-form-forgot" href="/retrieve">
						找回密码
					</a> -->
					<a-button type="primary" html-type="submit" class="login-form-button">
						登录
					</a-button>
					<!-- 				    <a class="login-form-regit" href="">
				      还没账号？点击我注册
				    </a> -->
				</a-form-item>
			</a-form>

		</div>
	</div>

</template>

<script>
	import TSCarousel from '../components/TSCarousel.vue'
	// import router from "@/router";
	import router from '../router/index.js'
	import request from '../utils/request.js'
	import axios from 'axios'
	export default {
		name: "Login",
		inject: ['reload'],
		data() {
			return {
				
			}
		},
		beforeCreate() {
			// 创建表单
			this.form = this.$form.createForm(this);
		},
		methods: {
			handleSubmit() {
				//先校验表单然后在判断
				//还差判断是否是学生或老师,再加一个判断实现,可以利用
				this.form.validateFields((err, values) => {
					if (!err) {
						console.log(values)
						//转JSON格式,转不转都无所谓
						const fromdata = JSON.parse(JSON.stringify(values))
						request.post('/api/login', fromdata)
							.then(res => {
								sessionStorage.setItem("user",JSON.stringify(res.data))
								if (res.data.identity == 0) {
									this.$message.success('管理员，登录成功');
									this.$router.push({
										path: '/admin/welcome'
									})
								} else if (res.data.identity == 1) {
									this.$message.success('学生，登录成功');
									this.$router.push({
										path: '/indexs/welcome'
									})
								} else if (res.data.identity == 2) {
									this.$message.success('老师，登录成功');
									this.$router.push({
										path: '/index/welcome'
									})
								} else {
									this.$message.error("该用户不存在！请重新登录！");
									this.form.resetFields();
									this.reload();									
								}
								console.log(res)
							})
							.catch(error => {
								this.$message.error('用户名或密码错误,请重新输入!');
								this.form.resetFields();
								this.reload();
								//console.log(error)
							})
					}
				});
			},
		},
		components: {
			TSCarousel,
		},
	};
</script>
<style scoped>
	.body {
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}

	.conbox {
		position: absolute;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
	}

	#components-form-demo-normal-login {
		/* background: url(../assets/bg.jpg); */
		border-radius: 15px;
		background-clip: padding-box;
		margin: 180px auto;
		width: 350px;
		padding: 15px 35px 15px 35px;
		background: #FFF;
		border: 1px solid #eaeaea;
		box-shadow: 0 0 25px #cac6c6;
	}

	.logintitle {
		text-align: center;
		color: #108EE9;
	}

	#components-form-demo-normal-login .login-form {
		max-width: 300px;
	}

	#components-form-demo-normal-login .login-form-forgot {
		float: right;
	}

	#components-form-demo-normal-login .login-form-button {
		width: 100%;
	}

	#components-form-demo-normal-login .login-form-regit {
		float: right;
		font-size: 13px;
	}
</style>
