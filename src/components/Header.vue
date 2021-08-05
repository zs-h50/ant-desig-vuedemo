<template>
	    <a-layout-header class="header">
	      <div class="logo" />
		  
		  <a-dropdown>
		      <a class="ant-dropdown-link" @click="e => e.preventDefault()">
			  <a-avatar style="backgroundColor:#87d068;" icon="user"/>
				{{username.account}} 
		      </a>
			  
		      <a-menu slot="overlay">
		        <a-menu-item>
		          <a href="/login" @click="removeid()">退出登录</a>
		        </a-menu-item>
		      </a-menu>
		    </a-dropdown>
	    </a-layout-header>
</template>

<script>
	const username = '';
	export default {
		data() {
			return{
				username,
				date:'',
			}
		},
		methods:{
			removeid(){
				sessionStorage.removeItem('user');
			}
		},
		mounted() {
			const user = sessionStorage.getItem("user");
			this.username = JSON.parse(user);
		}
	}
</script>

<style>
	.header{
		color: #FFFFFF;
	}
	.logo {
		width: 120px;
		height: 31px;
		background: rgba(255, 255, 255, 0.2);
		margin: 16px 28px 16px 0;
		float: left;
	}
	.ant-dropdown-link{
		/* 相对定位 */
		position: relative;
		float: right;
	}
</style>
