<template>
	<a-layout>
		<a-layout-sider>
			<!-- 左边的导航栏 -->
			<!-- :default-selected-keys="['2']" 默认选择导航栏的选项 -->
			<a-menu style="width: 256px;height:81vh;" :default-selected-keys="['0']" :open-keys.sync="openKeys"
				mode="inline" @click="handleClick" theme="dark">
				<a-sub-menu key="sub" @titleClick="titleClick">
					<span slot="title">
						<a-icon type="user" /><span>用户管理</span>
					</span>
					<a-menu-item-group key="t1">
						<template slot="title">
							<a-icon type="user" /><span>学生管理</span>
						</template>
						<a-menu-item key="1">
							<!-- 操作 1 -->
							<router-link to="">学生信息</router-link>
						</a-menu-item>
						<a-menu-item key="2">
							<!-- 操作 2 -->
							<router-link to="">学生家庭信息</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="t2">
						<template slot="title">
							<a-icon type="solution" /><span> 老师管理</span>
						</template>
						<a-menu-item key="3">
							<router-link to="">老师信息</router-link>
						</a-menu-item>
					</a-menu-item-group>
				</a-sub-menu>
				<a-sub-menu key="sub2" @titleClick="titleClick">
				        <span slot="title"><a-icon type="appstore" /><span>学校管理</span></span>
				        <a-menu-item key="4">
				          操作 4
				        </a-menu-item>
				        <a-menu-item key="5">
				          操作 5
				        </a-menu-item>
				        <a-sub-menu key="sub3" title="Submenu">
				          <a-menu-item key="6">
				            操作 6
				          </a-menu-item>
				          <a-menu-item key="7">
				            操作 7
				          </a-menu-item>
				        </a-sub-menu>
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
	export default {
		data() {
			return {
				openKeys: ['sub'],
			}
		},
		components: {
			Welcome,
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
