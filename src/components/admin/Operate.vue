<template>
	<!-- 放8条数据 -->
	<div>
		<a-button class="editable-add-btn" @click="handleAdd" type="primary">
			新增
		</a-button>
		<a-table bordered :data-source="dataSource" :columns="columns">
			
			<!-- EditableCell组件渲染的地方 -->
			<template slot="id" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record.key, 'id', $event)" />
			</template>
<!-- 			<template slot="account" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record.key, 'account', $event)" />
			</template>
			<template slot="password" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record.key, 'password', $event)" />
			</template> -->
			
			<template slot="operation" slot-scope="text, record">
				<a-popconfirm v-if="dataSource.length" title="是否要删除?" @confirm="() => onDelete(record.key)">
					<a href="javascript:;">删除</a>
				</a-popconfirm>
			</template>
		</a-table>
	</div>
</template>
<script>
	//组件
	import EditableCell from './EditableCell.vue'
	export default {
		components: {
			EditableCell,
		},
		data() {
			return {
				dataSource: [{
						key: '0',
						id:"1",
						account: 'Edward King 0',
						password: '32',
						identity: 'London, Park Lane no. 0',
					},
					{
						key: '1',
						id:"2",
						account: 'Edward King 1',
						password: '32',
						identity: 'London, Park Lane no. 1',
					},
				],
				count: 2,
				columns: [
					{
						title: 'ID',
						dataIndex: 'id',
						width:'15%',
						align:"center",
						scopedSlots: {
							customRender: 'id'
						},
					},
					{
						title: '用户',
						dataIndex: 'account',
						width: '15%',
						align:"center",
						scopedSlots: {
							customRender: 'account'
						},
					},
					{
						title: '密码',
						dataIndex: 'password',
						width: '15%',
						align:"center",
						scopedSlots: {
							customRender: 'password'
						},
					},
					{
						title: '身份',
						dataIndex: 'identity',
						width: '15%',
						align:"center",
						scopedSlots: {
							customRender: 'identity'
						},
					},
					{
						title: '操作',
						dataIndex: 'operation',
						align:"center",
						scopedSlots: {
							customRender: 'operation'
						},
					},
				],
			};
		},
		methods: {
			onCellChange(key, dataIndex, value) {
				const dataSource = [...this.dataSource];
				const target = dataSource.find(item => item.key === key);
				if (target) {
					target[dataIndex] = value;
					this.dataSource = dataSource;
				}
			},
			onDelete(key) {
				const dataSource = [...this.dataSource];
				this.dataSource = dataSource.filter(item => item.key !== key);
			},
			handleAdd() {
				const {
					count,
					dataSource
				} = this;
				const newData = {
					key: count,
					id:String(count+1) ,
					account: `Edward King ${count}`,
					password: 32,
					identity: `London, Park Lane no. ${count}`,
				};
				this.dataSource = [...dataSource, newData];
				this.count = count + 1;
			},
		},
	};
</script>
<style>


	.editable-add-btn {
		margin-bottom: 8px;
	}
</style>
