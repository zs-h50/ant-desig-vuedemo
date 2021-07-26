<template>
	    <a-layout-header class="header">
	      <div class="logo" />
		  <a-dropdown>
			  
		      <a class="ant-dropdown-link" @click="e => e.preventDefault()">
			  <a-avatar style="backgroundColor:#87d068" icon="user" />
		        李云龙 <a-icon type="down" />
		      </a>
		      <a-menu slot="overlay">
		        <a-menu-item>
		          <a href="/login">退出登录</a>
		        </a-menu-item>
		      </a-menu>
		    </a-dropdown>
	    </a-layout-header>
</template>

<script>
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
