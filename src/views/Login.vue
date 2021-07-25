<template>
	<div class="body">
		<TSCarousel />
		<div class="conbox">
			<a-form
				  id="components-form-demo-normal-login"
				  :form="form"
				  class="login-form"
				  @submit="handleSubmit"
				>
				<!-- required: true开启校验 -->
				<h2 class="logintitle">用户登录</h2>
				  <a-form-item>
				    <a-input
				      v-decorator="[
				        'userName',
				        { rules: [{ required: true, message: '请输入你的用户名！！！' }] },
				      ]"
				      placeholder="用户名"
				    >
				      <a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)" />
				    </a-input>
				  </a-form-item>
				  <a-form-item>
				    <a-input
				      v-decorator="[
				        'password',
				        { rules: [{ required: true, message: '请输入你的密码！！！' }] },
				      ]"
				      type="password"
				      placeholder="密码"
				    >
				      <a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)" />
				    </a-input>
				  </a-form-item>
				  <a-form-item>
				    <a-checkbox
				      v-decorator="[
				        'remember',
				        {
				          valuePropName: 'checked',
				          initialValue: true,
				        },
				      ]"
				    >
				      记住我
				    </a-checkbox>
				    <a class="login-form-forgot" href="">
				      找回密码
				    </a>
				    <a-button type="primary" html-type="submit" class="login-form-button">
				      登录
				    </a-button>
				    <a class="login-form-regit" href="">
				      还没账号？点击我注册
				    </a>
				  </a-form-item>
				</a-form>

		</div>
	</div>

</template>

<script>
	import TSCarousel from '../components/TSCarousel.vue'
export default {
	name:"Login",
    beforeCreate() {
      this.form = this.$form.createForm(this, { name: 'normal_login' });
    },
    methods: {
      handleSubmit() {
        this.form.validateFields((err, values) => {
          /* if (!err) {
            console.log('Received values of form: ', values);
          } */
        });
      },
    },
	components:{
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
	#components-form-demo-normal-login{
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
	.logintitle{
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
	#components-form-demo-normal-login .login-form-regit{
		float: right;
		font-size: 13px;
	}
</style>