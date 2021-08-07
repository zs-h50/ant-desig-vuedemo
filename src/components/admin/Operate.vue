<template>
	<div>
		<!-- 表格 -->
		<a-table bordered :data-source="dataSource" :columns="columns" :pagination="paginationOpt" row-key="id">
			<!-- 编辑 -->
			<span slot="identity" slot-scope="text, record">
				<span v-if="record.identity == 1">学生</span>
				<span v-if="record.identity == 2">老师</span>
				<span v-if="record.identity == 3">禁用</span>
			</span>
			<!-- 删除按钮 -->
			<template slot="operation" slot-scope="text,record">
				<a-button @click="showModal(record)">编辑</a-button>
				<a-modal title="修改" :visible="visible" @ok="handleOk" @cancel="handleCancel">
					<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 7 }"
						:wrapper-col="{ span: 12 }">
						<a-form-model-item label="用户账号" ref="account" prop="account">
							<a-input disabled v-model="upform.account" />
						</a-form-model-item>

						<a-form-model-item label="密码" ref="password" prop="password">
							<a-input v-model="upform.password" placeholder="请输入修改的密码" />
						</a-form-model-item>

						<a-form-model-item label="身份" ref="identity" prop="identity">
							<a-select v-model="upform.identity" placeholder="选择用户的身份">
								<a-select-option value="1">
									学生
								</a-select-option>
								<a-select-option value="2">
									老师
								</a-select-option>
								<a-select-option value="3">
									禁用
								</a-select-option>
							</a-select>
						</a-form-model-item>
					</a-form-model>
				</a-modal>
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
				dataSource: [],
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
					onShowSizeChange: (current, pageSize) => {
						this.paginationOpt.defaultCurrent = 1;
						this.paginationOpt.defaultPageSize = pageSize;
						//this.searchCameraFrom(); //显示列表的接口名称
					},
					// 改变每页数量时更新显示
					//onChange页码改变的回调，参数是改变后的页码及每页条数
					onChange: (current, size) => {
						this.paginationOpt.defaultCurrent = current;
						this.paginationOpt.defaultPageSize = size;
						//this.searchCameraFrom();
					},
				},
				columns,
				count: 2,
				visible: false,
				formLayout: 'horizontal', //表单布局
				form: this.$form.createForm(this),
				upform: {
					account: '',
					password: '',
					identity: ''
				},
				rules: {

				}
			};
		},
		created() {
			this.load()
		},
		methods: {
			showModal(record) {
				//console.log(record)
				this.upform = JSON.parse(JSON.stringify(record))
				console.log(this.upform)
				this.visible = true;
			},
			handleCancel(e) {
				console.log('关闭');
				this.visible = false;
			},
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
			handleOk(e) {
				this.$refs.ruleForm.validate(valid => {
					if (valid) {
						request.put("/api/admin/operate/update", this.upform)
							.then(res => {
								this.$message.success('修改用户成功！！！');
								this.reload();
							})
							.catch(res => {
								this.$message.error('修改用户失败！！！');
								this.reload();
							})
					} else {
						console.log('error submit!!');
						return false;
					}
				});
			},
			
		},
	}
</script>
<style scoped>
	.editable-add-btn {
		margin-bottom: 8px;
	}
</style>
