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
							操作 1
						</a-menu-item>
						<a-menu-item key="2">
							操作 2
						</a-menu-item>
					</a-menu-item-group>
					<a-menu-item-group key="g2">
						<template slot="title">
							<a-icon type="solution" /><span> 班级信息</span>
						</template>
						<a-menu-item key="3">
							操作 3
						</a-menu-item>
						<a-menu-item key="4">
							操作 4
						</a-menu-item>
					</a-menu-item-group>
				</a-sub-menu>
			</a-menu>
		</a-layout-sider>
		<!-- 右边的内容 -->
		<a-layout-content style="padding:15px 15px 15px 75px;">
			<Welcome></Welcome>
			<!-- 				<a-table :columns="columns" :data-source="data" :scroll="{ x: 1800, y: 300 }">
					    <a slot="action" slot-scope="text">action</a>
					  </a-table> -->
			<!-- <slot></slot> -->
		</a-layout-content>
	</a-layout>
</template>

<script>
	import Welcome from '@/components/Welcome.vue'

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
	export default {
		data() {
			return {
				current: ['mail'],
				openKeys: ['sub1'],
				data,
				columns
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
		}
	}
</script>

<style>
</style>
