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
							<router-link to="/indexs/userList">操作 1</router-link>
						</a-menu-item>
						<a-menu-item key="2">
							<!-- 操作 2 -->
							<router-link to="">操作 2</router-link>
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="g2">
						<template slot="title">
							<a-icon type="solution" /><span> 班级信息</span>
						</template>
						<a-menu-item key="3">
							<!-- 操作 3 -->
							<router-link to="">操作 3</router-link>
						</a-menu-item>
						<a-menu-item key="4">
							<!-- 操作 4 -->
							<router-link to="">操作 4</router-link>
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
<<<<<<< HEAD
	const columns = [{
			title: 'Full Name',
			width: 100,
			dataIndex: 'name',
			key: 'name',
			fixed: 'left'
		},
		{
			title: 'Age',
			width: 100,
			dataIndex: 'age',
			key: 'age',
			fixed: 'left'
		},
		{
			title: 'Column 1',
			dataIndex: 'address',
			key: '1',
			width: 150
		},
		{
			title: 'Column 2',
			dataIndex: 'address',
			key: '2',
			width: 150
		},
		{
			title: 'Column 3',
			dataIndex: 'address',
			key: '3',
			width: 150
		},
		{
			title: 'Column 4',
			dataIndex: 'address',
			key: '4',
			width: 150
		},
		{
			title: 'Column 5',
			dataIndex: 'address',
			key: '5',
			width: 150
		},
		{
			title: 'Column 6',
			dataIndex: 'address',
			key: '6',
			width: 150
		},
		{
			title: 'Column 7',
			dataIndex: 'address',
			key: '7',
			width: 150
		},
		{
			title: 'Column 8',
			dataIndex: 'address',
			key: '8',
			width: 150
		},
		{
			title: 'Column 9',
			dataIndex: 'address',
			key: '9'
		},
		{
			title: 'Action',
			key: 'operation',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action'
			},
		},
	];
	const data = [];
	for (let i = 0; i < 100; i++) {
		data.push({
			key: i,
			name: `Edrward ${i}`,
			age: 32,
			address: `London Park no. ${i}`,
		});
	}
=======
>>>>>>> 853250745a8985d818ab05d9a73ca08de1a6cdc5
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
<<<<<<< HEAD

=======
>>>>>>> 853250745a8985d818ab05d9a73ca08de1a6cdc5
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
		}
	}
</script>

<style>
</style>
