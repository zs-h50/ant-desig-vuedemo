<template>
	<a-layout>
		<a-layout-sider>
			<!-- 左边的导航栏 -->
			<!-- :default-selected-keys="['2']" 默认选择导航栏的选项 -->
			<a-menu style="width: 256px;height:81vh;" :default-selected-keys="['0']" :open-keys.sync="openKeys"
				mode="inline" @click="handleClick" theme="dark">
				<!-- 第一个菜单选项 -->
				<a-sub-menu key="sub1" @titleClick="titleClick">
					<span slot="title">
						<a-icon type="unordered-list" /><span>用户管理</span>
					</span>
					<a-menu-item-group key="g1">
						<template slot="title">
							<a-icon type="user" /><span>用户信息</span>
						</template>
						<a-menu-item key="1">
							<router-link to="operate">用户</router-link>
						</a-menu-item>
					</a-menu-item-group>
				</a-sub-menu>

				<a-sub-menu key="sub2" @titleClick="titleClick">
					<span slot="title">
						<a-icon type="unordered-list" /><span>学校管理</span>
					</span>
					<a-menu-item-group key="g2">
						<template slot="title">
							<a-icon type="user" /><span>学生信息</span>
						</template>
						<a-menu-item key="2">
							<router-link to="studentinfo">个人信息</router-link>
						</a-menu-item>
						<a-menu-item key="3">
							<router-link to="house">家庭信息</router-link>
						</a-menu-item>
						<a-menu-item key="4">
							<router-link to="courses">课程信息</router-link>
						</a-menu-item>
						<a-menu-item key="5">
							<router-link to="exam">成绩信息</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="g3">
						<template slot="title">
							<a-icon type="user" /><span>老师信息</span>
						</template>
						<a-menu-item key="6">
							<router-link to="teacher">个人信息</router-link>
						</a-menu-item>
						<a-menu-item key="7">
							<router-link to="">操作 2</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="g4">
						<template slot="title">
							<a-icon type="home" /><span>班级管理</span>
						</template>
						<a-menu-item key="8">
							<router-link to="fclass">班级信息</router-link>
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
	import Operate from './Operate.vue'
	import request from '@/utils/request.js'
	import StudentInformation from './StudentInformation.vue'
	import House from './House.vue'
	import Teacher from './Teacher.vue'
	import Course from './Course.vue'
	import Exam from './Exam.vue'
	import Fclass from './Fclass.vue'
 	export default {
		inject: ['reload'],
		data() {
			return {
				openKeys: ['sub'],
			}
		},
		components: {
			Welcome,
			Operate,
			StudentInformation,
			House,
			Teacher,
			Exam,
			Fclass
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
