<template>
	<div>
		<!-- 表格 -->
		<a-table bordered :data-source="dataSource" :columns="columns" :pagination="paginationOpt" row-key="id">
			<!-- 编辑 -->
			<!-- EditableCell组件渲染的地方 -->
			<template slot="password" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record, 'password', $event)" />
			</template>
			<template slot="identity" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record, 'identity', $event)" />
			</template>

			<!-- 删除按钮 -->
			<template slot="operation" slot-scope="text, record">
				<a-popconfirm v-if="dataSource.length" title="是否要删除?" ok-text="确定" cancel-text="取消"
					@confirm="() => onDelete(record.id)">
					<a-button disabled type="danger">删除</a-button>
				</a-popconfirm>
			</template>
		</a-table>
	</div>
</template>
<script>
	//组件
	import EditableCell from './EditableCell.vue'
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			dataIndex: 'id',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'id'
			},
		},
		{
			title: '用户',
			dataIndex: 'account',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'account'
			},
		},
		{
			title: '密码',
			dataIndex: 'password',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'password'
			},
		},
		{
			title: '身份',
			dataIndex: 'identity',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'identity'
			},
		},
		{
			title: '操作',
			dataIndex: 'operation',
			align: "center",
			scopedSlots: {
				customRender: 'operation'
			},
		},
	]

	export default {
		inject: ['reload'], //provide/inject可以轻松实现跨级访问父组件的数据
		data() {
			return {
				dataSource: [{
						key: '1',
						id: "1",
						account: 'Edward King 0',
						password: '32',
						identity: 'London, Park Lane no. 0',
					},
					{
						key: '2',
						id: "2",
						account: 'Edward King 1',
						password: '32',
						identity: 'London, Park Lane no. 1',
					},
				],
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				columns,
				count: 2,
				visible: false,
				formLayout: 'horizontal', //表单布局
				form: this.$form.createForm(this),

			};
		},
		created() {
			this.load()
		},
		methods: {
			//获取数据
			load() {
				request.post('/api/admin/operate')
					.then(res => {
						console.log(res.data)
						this.dataSource = res.data
					})
					.catch(error => {
						console.log(error)
					})
			},

			// 编辑
			onCellChange(record, dataIndex, value) {
				console.log(value)
				const id = record.id;
				const dataSource = [...this.dataSource];
				const target = dataSource.find(item => item.id === id);
				//console.log(target) 
				if (target) {
					target[dataIndex] = value;
					console.log(value)
					console.log("==========")
					console.log(target[dataIndex])
					console.log("==========")
					console.log(dataSource)
					this.dataSource = dataSource;
				}
				if(record != null){
					const user = JSON.parse(JSON.stringify(record))
					request.put("/api/admin/operate/update", user)
						.then(res => {
							this.$message.success('修改用户成功！！！');
							// this.reload();
						})
						.catch(res => {
							this.$message.error('修改用户失败！！！');
							this.reload();
						})
				}else{
					this.$message.error('不能为空！！！');
				}
				
			},
			// 删除
			onDelete(id) {
				console.log(id)
				request.delete("/api/admin/operate/delete/" + id)
					.then(res => {
						this.$message.success('删除用户成功！！！');
						this.reload();
					})
					.catch(error => {
						this.$message.error('删除用户失败！！！');
						this.reload();
					})
			},
			// 是否弹窗
			showModal() {
				this.visible = true;
			},
			// 关闭对话框
			handleCancel(e) {
				this.visible = false;
			},
		},
		components: {
			EditableCell,
		},
	};
</script>
<style>
	.editable-add-btn {
		margin-bottom: 8px;
	}
</style>
