<template>
	<a-layout>
		<a-layout-sider>
			<!-- 左边的导航栏 -->
			<!-- :default-selected-keys="['2']" 默认选择导航栏的选项 -->
			<a-menu style="width: 256px;height:81vh;" :default-selected-keys="['0']" :open-keys.sync="openKeys"
				mode="inline" @click="handleClick" theme="dark">
				<a-sub-menu key="sub1" @titleClick="titleClick">
					<span slot="title">
						<a-icon type="menu" /><span>菜单选项</span>
					</span>
					<a-menu-item-group key="g1">
						<template slot="title">
							<a-icon type="user" /><span> 个人信息</span>
						</template>
						<a-menu-item key="1">
							<!-- 操作 1 -->
							<router-link to="userlist">操作 1</router-link>
						</a-menu-item>
						<a-menu-item key="2">
							<!-- 操作 2 -->
							<router-link to="scorelist">操作 2</router-link>
						</a-menu-item>
						<a-menu-item key="3">
							<!-- 操作 3 -->
							<router-link to="scorelist">操作 3</router-link>
						</a-menu-item>
						<a-menu-item key="4">
							<!-- 操作 4 -->
							<router-link to="scorelist">操作 4</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="g2">
						<template slot="title">
							<a-icon type="solution" /><span> 学校信息</span>
						</template>
						<a-menu-item key="5">
							<!-- 操作 5 -->
							<router-link to="teamlist">操作 5</router-link>
						</a-menu-item>
						<a-menu-item key="6">
							<!-- 操作 6 -->
							<router-link to="teacherlist">操作 6</router-link>
						</a-menu-item>
					</a-menu-item-group>
				</a-sub-menu>
			</a-menu>
		</a-layout-sider>
		<!-- 右边的内容 -->
		<a-layout-content style="padding:15px 15px 15px 75px;">
			<!-- 路由匹配到的组件将渲染在这里 -->
			<router-view></router-view>
			<!-- <Welcome></Welcome> -->
		</a-layout-content>
	</a-layout>
</template>

<script>
	import Welcome from '@/components/Welcome.vue'
	import UserList from '@/components/student/UserList.vue'
	import ScoreList from '@/components/student/ScoreList.vue'
	import TeamList from '@/components/student/TeamList.vue'
	import TeacherList from '@/components/student/TeacherList.vue'
	export default {
		data() {
			return {
				// current: ['mail'],
				openKeys: ['sub1'],
			}
		},
		components: {
			Welcome,
			UserList,
			ScoreList,
			TeamList,
			TeacherList,
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
