<template>
	<!-- 放8条数据 -->
	<div>
		<a-button class="editable-add-btn" @click="showModal" type="primary">
			新增
		</a-button>
		<!-- 对话框 -->
		<a-modal title="新增用户" :visible="visible" @cancel="handleCancel" :footer="null">
			<!-- 表单 -->
			<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmit">
				<a-form-item label="用户名">
					<a-input v-decorator="['account', { rules: [{ required: true, message: '用户名不能为空！' }] }]"
						placeholder="输入工号或者学号" />
				</a-form-item>
				<a-form-item label="密码">
					<a-input v-decorator="['password', { rules: [{ required: true, message: '密码不能为空！' }] }]"
						placeholder="输入密码" />
				</a-form-item>
				<a-form-item label="身份">
					<a-select v-decorator="[
			          'identity',
			          { rules: [{ required: true, message: '用户的身份不能为空！' }] },
			        ]" placeholder="请选择用户的身份对象">
						<a-select-option value="1">
							学生
						</a-select-option>
						<a-select-option value="2">
							教师
						</a-select-option>
					</a-select>
				</a-form-item>
				<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
					<!-- 不缺失方法 -->
					<a-button type="primary" html-type="submit">
						创建
					</a-button>
				</a-form-item>
			</a-form>
		</a-modal>

		<!-- 表格 -->
		<a-table bordered :data-source="dataSource" :columns="columns" :pagination="paginationOpt" row-key="id">
			<!-- 编辑 -->
			<!-- EditableCell组件渲染的地方 -->
			<template slot="account" slot-scope="text, record">
				<editable-cell :text="text" @change="onCellChange(record, 'account', $event)" />
			</template>
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
					<a-button type="danger">删除</a-button>
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
				console.log(target) //
				if (target) {
					target[dataIndex] = value;
					console.log(value)
					console.log("==========")
					console.log(target[dataIndex])
					console.log("==========")
					console.log(dataSource)
					this.dataSource = dataSource;
				}
				const user = JSON.parse(JSON.stringify(target))
				request.put("/api/admin/operate/update", user)
					.then(res => {
						this.$message.success('修改用户成功！！！');
						// this.reload();
					})
					.catch(res => {
						this.$message.error('修改用户失败！！！');
						this.reload();
					})
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
			//创建用户请求的接口
			handleSubmit(e) {
				e.preventDefault();
				this.form.validateFields((err, values) => {
					const datas = JSON.parse(JSON.stringify(values))
					if (!err) {
						//打印表单的值
						console.log(values);
						request.post('/api/admin/operate/adds', datas)
							.then(res => {
								//清空表单
								this.$message.success('新增用户成功！！！');
								this.form.resetFields();
								this.reload(); //刷新
							})
							.catch(error => {
								this.$message.error('新增用户失败！！！');
								this.form.resetFields();
								this.reload(); //刷新
							})
					}
				});
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
