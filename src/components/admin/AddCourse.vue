<template>
	<div>
		<!-- 表格 -->
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">
			新增
			<a-modal title="新增" :visible="visible" @ok="AddhandleOk" @cancel="handleCancel">
				<!-- 放个表单 -->
				<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 7 }"
					:wrapper-col="{ span: 12 }">
					<a-form-model-item label="课程标识" ref="cId" prop="cId">
						<a-input v-model="upform.cId" placeholder="请输入课程编号" />
					</a-form-model-item>
					<a-form-model-item label="课程编号" ref="cNo" prop="cNo">
						<a-input v-model="upform.cNo" placeholder="请输入课程编号" />
					</a-form-model-item>

					<a-form-model-item label="课程名称" ref="cName" prop="cName">
						<a-input v-model="upform.cName" placeholder="请输入课程名称" />
					</a-form-model-item>

					<a-form-model-item label="课程状态" ref="cFettle" prop="cFettle">
						<a-select v-model="upform.cFettle" placeholder="选择">
							<a-select-option value="1">
								开课
							</a-select-option>
							<a-select-option value="2">
								闭课
							</a-select-option>
						</a-select>
					</a-form-model-item>
					<a-form-model-item label="备注" ref="cRemark" prop="cRemark">
						<a-input v-model="upform.cRemark" placeholder="请输入备注" />
					</a-form-model-item>
				</a-form-model>
			</a-modal>

		</a-button>
		<a-table bordered :data-source="dataSource" :columns="columns" :pagination="paginationOpt" row-key="cId">
			<span slot="cFettle" slot-scope="text, record">
				<span v-if="record.cFettle == 1">开课</span>
				<span v-if="record.cFettle == 2">闭课</span>
			</span>
			<template slot="operation" slot-scope="text,record">
				<a-button @click="showModals(record)">编辑</a-button>
				<a-modal title="修改" :visible="visibles" @ok="handleOk" @cancel="handleCancels">
					<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 7 }"
						:wrapper-col="{ span: 12 }">
						<a-form-model-item label="课程编号" ref="cNo" prop="cNo">
							<a-input disabled v-model="upform.cNo" />
						</a-form-model-item>

						<a-form-model-item label="课程名称" ref="cName" prop="cName">
							<a-input v-model="upform.cName" placeholder="请输入修改的课程名称" />
						</a-form-model-item>

						<a-form-model-item label="课程状态" ref="cFettle" prop="cFettle">
							<a-select v-model="upform.cFettle" placeholder="选择">
								<a-select-option value="1">
									开课
								</a-select-option>
								<a-select-option value="2">
									闭课
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item label="备注" ref="cRemark" prop="cRemark">
							<a-input v-model="upform.cRemark" placeholder="请输入修改的备注" />
						</a-form-model-item>
					</a-form-model>
				</a-modal>
			</template>
			<template slot="operation2" slot-scope="text,record">
				<a-button type="danger" @click="dele(record.cNo)">删除</a-button>
			</template>
			<template slot="operation3" slot-scope="text,record">
				<a-button type="dashed" @click="">查看</a-button>
			</template>
		</a-table>
	</div>
</template>
<script>
	//组件
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			dataIndex: 'cId',
			width: '10%',
			align: "center",
			scopedSlots: {
				customRender: 'cId'
			},
		},
		{
			title: '课程编号',
			dataIndex: 'cNo',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'cNo'
			},
		},
		{
			title: '课程名称',
			dataIndex: 'cName',
			width: '20%',
			align: "center",
			scopedSlots: {
				customRender: 'cName'
			},
		},
		{
			title: '课程状态',
			dataIndex: 'cFettle',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'cFettle'
			},
		},
		{
			title: '备注',
			dataIndex: 'cRemark',
			width: '15%',
			align: "center",
			scopedSlots: {
				customRender: 'cRemark'
			},
		},
		{
			title: '操作1',
			dataIndex: 'operation',
			align: "center",
			scopedSlots: {
				customRender: 'operation'
			},
		},
		{
			title: '操作2',
			dataIndex: 'operation2',
			align: "center",
			scopedSlots: {
				customRender: 'operation2'
			},
		},
		{
			title: '操作3',
			dataIndex: 'operation3',
			align: "center",
			scopedSlots: {
				customRender: 'operation3'
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
				},
				columns,
				visible: false,
				visibles: false,
				formLayout: 'horizontal', //表单布局
				form: this.$form.createForm(this),
				upform: {
					cId:'',
					cNo: '',
					cName: '',
					cFettle: '',
					cRemark: ''
				},
				rules: {
					cId: [{
						required: true,
						message: '请输入课程编号',
						trigger: 'blur'
					}, ],
					cNo: [{
						required: true,
						message: '请输入课程编号',
						trigger: 'blur'
					}, ],
					cName: [{
						required: true,
						message: '请输入课程名称',
						trigger: 'blur'
					}, ],
					cFettle: [{
						required: true,
						message: '请输入课程状态',
						trigger: 'blur'
					}, ],
					cRemark: [{
						required: false,
						trigger: 'blur'
					}, ],
				}
			};
		},
		created() {
			this.load()
		},
		methods: {
			showModal() {
				this.visible = true
			},
			showModals(record) {
				//console.log(record)
				this.upform = JSON.parse(JSON.stringify(record))
				console.log(this.upform)
				this.visibles = true;
			},
			handleCancel(e) {
				console.log('关闭');
				this.visible = false;
			},
			handleCancels(e) {
				console.log('关闭');
				this.visibles = false;
			},
			//获取数据
			load() {
				request.post('/api/admin/addcourse/select')
					.then(res => {
						console.log(res.data)
						this.dataSource = res.data
					})
					.catch(error => {
						console.log(error)
					})
			},
			AddhandleOk(e) {
				const datas = JSON.parse(JSON.stringify(this.upform))
				this.$refs.ruleForm.validate(valid => {
					if (valid) {
						request.post('/api/admin/addcourse',datas)
							.then(res => {
								this.$message.success("新增课程成功!!");
								this.reload(); //刷新
							})
							.catch(error => {
								this.$message.error("新增课程失败,课程已存在!!");
								this.reload(); //刷新
							})
					} else {
						console.log('error submit!!');
						return false;
					}
				});
			},
			handleOk(e) {
				this.$refs.ruleForm.validate(valid => {
					if (valid) {
						request.post('/api/admin/updatecourse', this.upform)
						.then(res => {
							this.$message.success("修改课程成功!!");
							this.reload(); //刷新
						})
						.catch(error => {
							this.$message.error("修改课程失败!!");
							this.reload(); //刷新
						})
					} else {
						console.log('error submit!!');
						return false;
					}
				});
			},
			dele(cNo){
				request.delete("/api/admin/deletcourse"+cNo)
				.then(res => {
					this.$message.success("删除课程成功!!");
					this.reload(); //刷新
				})
				.catch(error =>{
					this.$message.error("删除课程失败!!");
					this.reload(); //刷新
				})
			}
		},
	}
</script>
<style scoped>
	.editable-add-btn {
		margin-bottom: 8px;
	}
</style>
