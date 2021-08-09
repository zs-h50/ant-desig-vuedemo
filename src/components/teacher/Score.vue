<template>
	<div>
		<a-input-search placeholder="请输入要搜索课程" enter-button="搜索" size="large" class="input-search" @search="onSearch" />
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">增加
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
					<a-form-item label="学生">
						<a-select v-decorator="['sId', { rules: [{ required: true, message: '学生标识不能为空'}]}]"
							placeholder="请选择学生">
							<a-select-option v-for="(item,index) in Data" :value="item.student.sId">
								{{item.student.sName}}
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="班级">
						<a-select v-decorator="['cId', { rules: [{ required: false, message: '班级'}]}]"
							placeholder="请输入班级">
							<a-select-option v-for="(item,index) in courserArr" :value="item.fclass.cId">
								{{item.fclass.classname}}
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="年份">
						<a-input v-decorator="['aYears', { rules: [{ required: true, message: '年份不能为空'}]}]"
							placeholder="请输入年份" />
					</a-form-item>
					<a-form-item label="学期">
						<a-select v-decorator="[
					  'aSemester',
					  { rules: [{ required: true, message: '学期不能为空' }] },
					]" placeholder="选择学期">
							<a-select-option value="1">
								第一学期
							</a-select-option>
							<a-select-option value="2">
								第二学期
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="课程成绩">
						<a-input v-decorator="['aScore', { rules: [{ required: true, message: '课程成绩不能为空'}]}]"
							placeholder="请输入课程成绩" />
					</a-form-item>

					<a-form-item label="备注">
						<a-input v-decorator="['aRemark', { rules: [{ required: false, message: '备注不能为空'}]}]"
							placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form>
			</a-modal>
		</a-button>
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 600,y:385}" row-key="aId">
			<span slot="aSemester" slot-scope="text,record">
				<span v-if="record.aSemester == 1">第一学期</span>
				<span v-if="record.aSemester == 2">第二学期</span>
			</span>
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
					<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }"
						@submit="enditSubmit">
						<a-form-item label="学生标识">
							<a-input disabled v-model:value="upform.sId"
								v-decorator="['sId', { rules: [{ required: true, message: '学生标识不能为空'}]}]"
								placeholder="请输入学生标识" />
						</a-form-item>
						<a-form-item label="班级标识">
							<a-input disabled v-model:value="upform.cId"
								v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
								placeholder="请输入班级标识" />
						</a-form-item>
						<a-form-item label="年份">
							<a-input disabled v-model:value="upform.aYears"
								v-decorator="['aYears', { rules: [{ required: true, message: '年份不能为空'}]}]"
								placeholder="请输入年份" />
						</a-form-item>
						<a-form-item label="学期">
							<a-select disabled v-model:value="upform.aSemester" v-decorator="[
						  'aSemester',
						  { rules: [{ required: true, message: '学期不能为空' }] },
						]" placeholder="选择学期">
								<a-select-option value="1">
									第一学期
								</a-select-option>
								<a-select-option value="2">
									第二学期
								</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="课程成绩">
							<a-input v-model:value="upform.aScore"
								v-decorator="['aScore', { rules: [{ required: true, message: '课程成绩不能为空'}]}]"
								placeholder="请输入课程成绩" />
						</a-form-item>

						<a-form-item label="备注">
							<a-input v-model:value="upform.aRemark"
								v-decorator="['aRemark', { rules: [{ required: false, message: '备注不能为空'}]}]"
								placeholder="请输入备注" />
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
				@click="delstu(record.aId)">删除</a-button>
		</a-table>
	</div>
</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: '标识',
			width: 100,
			align: 'center',
			dataIndex: 'aId',
			key: 'aId',
			fixed: 'left'
		},
		{
			title: '学生姓名',
			width: 100,
			align: 'center',
			dataIndex: 'student.sName',
			key: 'student.sName',
			fixed: 'left'
		},
		{
			title: '课程编号',
			align: 'center',
			width: 100,
			dataIndex: 'course.cNo',
			key: '1'
		},
		{
			title: '课程名称',
			align: 'center',
			width: 100,
			dataIndex: 'course.cName',
			key: '2'
		},
		{
			title: '年份',
			align: 'center',
			width: 100,
			dataIndex: 'aYears',
			key: '3'
		},
		{
			title: '学期',
			align: 'center',
			width: 100,
			dataIndex: 'aSemester',
			key: '4',
			scopedSlots: {
				customRender: 'aSemester'
			},
		},
		{
			title: '班级名称',
			align: 'center',
			width: 100,
			dataIndex: 'fclass.classname',
			key: '5'
		},
		{
			title: '备注',
			align: 'center',
			width: 100,
			dataIndex: 'aRemark',
			key: '6'
		},
		{
			title: '成绩',
			key: '7',
			dataIndex: 'aScore',
			fixed: 'right',
			width: 100,
			align: 'center',
		},
		{
			title: '操作',
			key: 'operation2',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作',
			key: 'operation3',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action3'
			},
		},
	];

	const dataSource = [{
		aId: 1,
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				columns,
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource,
				dates: '',
				Data: [],
				courserArr:[],
				datas: '', //搜索框	
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
					sId: '',
					cId: '',
					aYears: '',
					aSemester: '',
					aScore: '',
					aRemark: '',
				},

			};
		},
		created() {
			const user = sessionStorage.getItem("user");
			const users = JSON.parse(user);
			this.dates = users.account;
			this.teacherexamload()
			this.studentload()
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
			teacherexamload() {
				request.post('/api/teacher/exam/select', this.dates)
					.then(res => {
						console.log(res.data)
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("查询失败！")
						//this.reload();
					})
			},
			//查看老师授课的班级
			courseload() {
				request.post('/api/teacher/course/select', this.dates)
					.then(res => {
						//console.log(res.data)
						this.courserArr = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			// 查询学生信息
			studentload() {
				request.post('/api/education/teacher/student/select', this.dates)
					.then(res => {
						console.log(res.data)
						this.Data = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			//添加
			addSubmit() {
				this.form.validateFields((err, values) => {
					if (!err) {
						const datae = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/teacher/exam/add', datae)
							.then(res => {
								if (res.code == "100") {
									this.$message.error(res.msg)
								} else if (res.code == "0") {
									this.$message.success("添加成功！")
									this.reload(); //刷新
								}
							})
							.catch(error => {
								this.$message.error("学生与班级不符合！")
								//this.reload();  //刷新
							})
					}
				});
			},
			enditSubmit() {
				request.post('/api/teacher/exam/update', this.upform)
					.then(res => {
						this.$message.success("修改成功！")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("修改失败！")
						this.reload(); //刷新
					})
			},
			onSearch(value) {
				console.log(value)
				const result = value;
				request.post('/api/admin/exam/select/search', result)
					.then(res => {
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("搜索失败！")
						this.reload();
					})
			},
			delstu(id) {
				console.log(id)
				//const sid = id
				request.delete('/api/teacher/exam/delete/' + id)
					.then(res => {
						this.$message.success("删除成功!!")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("删除失败!!")
						//this.reload();  //刷新
					})
			},
		}
	};
</script>
<style scoped>
	.input-search {
		width: 300px;
		float: right;
	}
</style>
