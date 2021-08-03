<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1450, y: 385 }" :pagination="paginationOpt"
		row-key="eId">
		
		<span slot="Fettle" slot-scope="text,record">
			<span v-if="record.eFettle == 0">开课</span>
			<span v-if="record.eFettle == 1">结课</span>
		</span>
		<span slot="eSemester" slot-scope="text,record">
			<span v-if="record.eSemester == 1">第一学期</span>
			<span v-if="record.eSemester == 2">第二学期</span>
		</span>
		
		<a-button slot="action1" slot-scope="text,record" size="small" @click="showModal()" type="primary"
			icon="plus-square">
			新增
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
					<a-form-item label="班级标识">
						<a-input v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
							placeholder="请输入班级标识" />
					</a-form-item>
					<a-form-item label="课程标识">
						<a-input v-decorator="['courseId',{ rules: [{ required: true, message: '课程标识不能为空' }] },
					]" placeholder="请输入课程标识"></a-input>
					</a-form-item>
					<a-form-item label="老师标识">
						<a-input v-decorator="['tId', { rules: [{ required: true, message: '老师标识不能为空'}]}]"
							placeholder="请输入老师标识" />
					</a-form-item>
					<a-form-item label="年份">
						<a-input v-decorator="['eYear', { rules: [{ required: true, message: '年份不能为空'}]}]"
							placeholder="请输入年份" />
					</a-form-item>
					<a-form-item label="学期">
						<a-select v-decorator="[
						  'eSemester',
						  { rules: [{ required: true, message: '学期不能为空' }] },
						]" placeholder="请选择">
								<a-select-option value="1">
									第一学期
								</a-select-option>
								<a-select-option value="2">
									第二学期
								</a-select-option>
							</a-select>
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-decorator="[
					  'eFettle',
					  { rules: [{ required: true, message: '状态不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								开课
							</a-select-option>
							<a-select-option value="1">
								结课
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="备注">
						<a-input v-decorator="['eRemark', { rules: [{ required: false}]}]" placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form>
			</a-modal>
		</a-button>
		<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
			<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
				<!-- 放个表单 -->
				<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit">
					<a-form-item label="班级标识">
						<a-input v-model:value="upform.cId" v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
							placeholder="请输入班级标识" />
					</a-form-item>
					<a-form-item label="课程标识">
						<a-input v-model:value="upform.courseId" v-decorator="['courseId',{ rules: [{ required: true, message: '课程标识不能为空' }] },
					]" placeholder="请输入课程标识"></a-input>
					</a-form-item>
					<a-form-item label="老师标识">
						<a-input v-model:value="upform.tId" v-decorator="['tId', { rules: [{ required: true, message: '老师标识不能为空'}]}]"
							placeholder="请输入老师标识" />
					</a-form-item>
					<a-form-item label="年份">
						<a-input v-model:value="upform.eYear" v-decorator="['eYear', { rules: [{ required: true, message: '年份不能为空'}]}]"
							placeholder="请输入年份" />
					</a-form-item>
					<a-form-item label="学期">
						<a-select v-model:value="upform.eSemester" v-decorator="[
						  'eSemester',
						  { rules: [{ required: true, message: '学期不能为空' }] },
						]" placeholder="请选择">
								<a-select-option value="1">
									第一学期
								</a-select-option>
								<a-select-option value="2">
									第二学期
								</a-select-option>
							</a-select>
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-model:value="upform.eFettle" v-decorator="[
					  'eFettle',
					  { rules: [{ required: true, message: '状态不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								开课
							</a-select-option>
							<a-select-option value="1">
								结课
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="备注">
						<a-input v-model:value="upform.eRemark" v-decorator="['eRemark', { rules: [{ required: false}]}]" placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form-model>
			</a-modal>
		</a-button>
		<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
			@click="delstu(record.eId)">删除</a-button>
	</a-table>
</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'eId',
			key: 'eId',
			fixed: 'left'
		},
		{
			title: '课程编号',
			width: 100,
			align: 'center',
			dataIndex: 'course.cNo',
			key: 'course.cNo',
			fixed: 'left'
		},
		{
			title: '课程名称',
			width: 100,
			align: 'center',
			dataIndex: 'course.cName',
			key: 'course.cName',
		},
		{
			title: '授课老师',
			width: 100,
			align: 'center',
			dataIndex: 'teacher.tName',
			key: 'teacher.tName',
		},
		{
			title: '年份',
			dataIndex: 'eYear',
			key: '1',
			width: 150,
			align: 'center',
		},
		{
			title: '班级名称',
			dataIndex: 'fclass.classname',
			key: '2',
			width: 150,
			align: 'center',
		},
		{
			title: '班级人数',
			dataIndex: 'fclass.cNumber',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '学期',
			dataIndex: 'eSemester',
			key: '4',
			width: 150,
			align: 'center',
			scopedSlots:{
				customRender:'eSemester'
			}
		},
		{
			title: '状态',
			dataIndex: 'eFettle',
			key: '5',
			width: 150,
			align: 'center',
			scopedSlots:{
				customRender:'Fettle'
			}
		},
		{
			title: '备注',
			dataIndex: 'eRemark',
			key: '6',
			width: 150,
			align: 'center',
		},
		{
			title: '操作1',
			key: 'operation1',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action1'
			},
		},
		{
			title: '操作2',
			key: 'operation2',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作3',
			key: 'operation3',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action3'
			},
		},
	];

	const dataSource = [{
		eId: '1',
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource,
				columns,
				visible: false,
				visibles: false,
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				upform: {
					eId: '',
					cId: '',
					tId: '',
					eYear: '',
					eSemester: '',
					eFettle: '',
					eRemark: '',
					courseId: '',
				},
			};
		},
		created() {
			this.courseload()
		},
		methods: {
			showModal() {
				this.visible = true
			},
			enditModal(record) {
				this.upform = JSON.parse(JSON.stringify(record))
				this.visibles = true
			},
			handleCancel(e) {
				this.visible = false;
			},
			handleCancels(e) {
				this.visibles = false;
			},
			courseload() {
				request.post('/api/admin/course/select')
					.then(res => {
						console.log(res.data)
						//this.dataSource.classname = res.data.fclass.classname
						this.dataSource = res.data
						//this.reload();  //刷新
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			addSubmit() {
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/admin/course/add', datas)
							.then(res => {
								this.$message.success("添加成功！")
								this.reload(); //刷新
							})
							.catch(error => {
								this.$message.error("添加失败！")
								this.reload(); //刷新
							})
					}
				});
			},
			editSubmit() {
				request.post('/api/admin/course/update', this.upform)
					.then(res => {
						this.$message.success("修改成功！")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("修改失败！")
						this.reload(); //刷新
					})
			},
			// 删除
			delstu(id) {
				console.log(id)
				//const sid = id
				request.delete('/api/admin/course/delete/' + id)
					.then(res => {
						this.$message.success("删除成功!!")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("删除失败!!")
						this.reload(); //刷新
					})
			},
		},
		components: {

		}
	};
</script>
