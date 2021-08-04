<template>
	<a-layout>
		<a-layout-sider>
			<!-- 左边的导航栏 -->
			<!-- :default-selected-keys="['2']" 默认选择导航栏的选项 -->
			<a-menu style="width: 256px;height:81vh;" :default-selected-keys="['0']" :open-keys.sync="openKeys"
				mode="inline" @click="handleClick" theme="dark">
				<a-sub-menu key="sub" @titleClick="titleClick">
					<span slot="title">
						<a-icon type="bars" /><span>菜单选项</span>
					</span>
					<a-menu-item-group key="t1">
						<template slot="title">
							<a-icon type="user" /><span> 个人信息</span>
						</template>
						<a-menu-item key="1">
							<!-- 操作 1 -->
							<router-link to="myself">个人信息</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="t2">
						<template slot="title">
							<a-icon type="solution" /><span> 学校信息</span>
						</template>
						<a-menu-item key="3">
							<router-link to="score">成绩</router-link>
						</a-menu-item>
						<a-menu-item key="4">
							<router-link to="course">课程</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="t3">
						<template slot="title">
							<a-icon type="solution" /><span> 账户信息</span>
						</template>
						<a-menu-item key="5">
							<router-link to="upteacher">修改密码</router-link>
						</a-menu-item>
					</a-menu-item-group>
				</a-sub-menu>
			</a-menu>
		</a-layout-sider>
		<!-- 右边的内容 -->
		<a-layout-content style="padding:15px 15px 15px 75px;">
			<!-- 路由匹配到的组件将渲染在这里 -->
			<router-view></router-view>
		</a-layout-content>
	</a-layout>
</template>

<script>
	import Welcome from '../Welcome.vue'
	import Myself from './Myself.vue'
	import Score from './Score.vue'
	import Course from './Course.vue'
	import Updataps from './Updataps.vue'
	export default {
		data() {
			return {
				openKeys: ['sub'],
			}
		},
		components: {
			Welcome,
			Myself,
			Score,
			Course,
			Updataps,
		},
		watch: {
			openKeys(val) {
				console.log('openKeys', val);
			},
		},
		methods: {
			handleClick(e) {
				console.log('click', e);
			},
			titleClick(e) {
				console.log('titleClick', e);
			},
		},
	}
</script>

<style>
</style>
