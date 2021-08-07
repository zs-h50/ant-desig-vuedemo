<template>
	<div>
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">
			新增
			<a-modal width="80%" title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
					<a-form-item label="教师编号">
						<a-input disabled v-decorator="['tNo', { rules: [{ required: false, message: '教师编号不能为空'}]}]"
							placeholder="请输入教师编号" />
					</a-form-item>
					<a-form-item label="教师姓名">
						<a-input v-decorator="['tName',{ rules: [{ required: true, message: '教师姓名不能为空' }] },
					]" placeholder="请输入教师姓名"></a-input>
					</a-form-item>
					<a-form-item label="性别">
						<a-select v-decorator="['tGender',{ rules: [{ required: true, message: '性别不能为空' }] },]"
							placeholder="选择性别">
							<a-select-option value="1">
								男
							</a-select-option>
							<a-select-option value="0">
								女
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="电话">
						<a-input
							v-decorator="['tPhone', { rules: [{ required: true, message: '电话不能为空'},{min:11,len:11,message: '请输入正确的格式'}]}]"
							placeholder="请输入电话" />
					</a-form-item>
					<a-form-item label="邮箱">
						<a-input
							v-decorator="['tEmail', { rules: [{ required: true, message: '邮箱不能为空'},{type:'email',message: '请输入正确的格式'}]}]"
							placeholder="请输入邮箱" />
					</a-form-item>
					<a-form-item label="出生日期" style="margin-bottom:0;">
						<a-date-picker v-decorator="['tBirthday', { rules: [{ required: true, message: '出生日期不能为空' }] }]"
							style="width: 100%" />
					</a-form-item>
					<a-form-item label="身份证号码">
						<a-input
							v-decorator="['tCard', { rules: [{ required: true, message: '身份证号码不能为空'},{min:18,len:18,message: '请输入正确的格式'}]}]"
							placeholder="请输入身份证号码" />
					</a-form-item>
					<a-form-item label="毕业学校">
						<a-input v-decorator="['tSchool', { rules: [{ required: true, message: '毕业学校不能为空'}]}]"
							placeholder="请输入毕业学校" />
					</a-form-item>
					<a-form-item label="毕业年份">
						<a-input v-decorator="['tYear', { rules: [{ required: true, message: '毕业年份不能为空'}]}]"
							placeholder="请输入毕业年份" />
					</a-form-item>
					<a-form-item label="学历">
						<a-select v-decorator="[
					  'tEducation',
					  { rules: [{ required: true, message: '学历不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								大专
							</a-select-option>
							<a-select-option value="1">
								本科
							</a-select-option>
							<a-select-option value="2">
								硕士
							</a-select-option>
							<a-select-option value="3">
								博士
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="学位">
						<a-select v-decorator="[
					  'tDegree',
					  { rules: [{ required: true, message: '学位不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								学士
							</a-select-option>
							<a-select-option value="1">
								硕士
							</a-select-option>
							<a-select-option value="2">
								博士
							</a-select-option>
							<a-select-option value="3">
								院士
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="专业">
						<a-input v-decorator="['tMajor', { rules: [{ required: true, message: '专业不能为空'}]}]"
							placeholder="请输入专业" />
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-decorator="[
					  'tFettle',
					  { rules: [{ required: true, message: '状态不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								在职
							</a-select-option>
							<a-select-option value="1">
								离职
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="备注">
						<a-input v-decorator="['tRemark', { rules: [{ required: false}]}]" placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 20 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form>
			</a-modal>
		</a-button>

		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1950, y: 385 }" :pagination="paginationOpt"
			row-key="tId">
			<span slot="tGender" slot-scope="text,record">
				<span v-if="record.tGender == 0">女</span>
				<span v-if="record.tGender == 1">男</span>
			</span>
			<span slot="tEducation" slot-scope="text,record">
				<span v-if="record.tEducation == 0">大专</span>
				<span v-if="record.tEducation == 1">本科</span>
				<span v-if="record.tEducation == 2">硕士</span>
				<span v-if="record.tEducation == 3">博士</span>
			</span>
			<span slot="tDegree" slot-scope="text,record">
				<span v-if="record.tDegree == 0">学士</span>
				<span v-if="record.tDegree == 1">硕士</span>
				<span v-if="record.tDegree == 2">博士</span>
				<span v-if="record.tDegree == 3">院士</span>
			</span>
			<span slot="tFettle" slot-scope="text,record">
				<a-tag color="green" v-if="record.tFettle == 0" style="font-size: 13px;">在职</a-tag>
				<a-tag color="red" v-if="record.tFettle == 1" style="font-size: 13px;">离职</a-tag>
			</span>
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" width="80%" :visible="visibles" :footer="null" @cancel="handleCancels">
					<!-- 放个表单 -->
					<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 5 }"
						:wrapper-col="{ span: 12 }">
						<a-form-model-item ref="tNo" prop="tNo" label="教师编号">
							<a-input disabled v-model="upform.tNo" placeholder="请输入教师编号" />
						</a-form-model-item>
						<a-form-model-item ref="tName" prop="tName" label="教师姓名">
							<a-input v-model="upform.tName" placeholder="请输入教师姓名"></a-input>
						</a-form-model-item>
						<a-form-model-item ref="tGender" prop="tGender" label="性别">
							<a-select v-model="upform.tGender" placeholder="选择性别">
								<a-select-option value="1">
									男
								</a-select-option>
								<a-select-option value="0">
									女
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="tPhone" prop="tPhone" label="电话">
							<a-input v-model="upform.tPhone" placeholder="请输入电话" />
						</a-form-model-item>
						<a-form-model-item ref="tEmail" prop="tEmail" label="邮箱">
							<a-input v-model="upform.tEmail" placeholder="请输入邮箱" />
						</a-form-model-item>
						<a-form-model-item ref="tBirthday" prop="tBirthday" label="出生日期" style="margin-bottom:0;">
							<a-date-picker v-model="upform.tBirthday" style="width: 100%" />
						</a-form-model-item>
						<a-form-model-item ref="tCard" prop="tCard" label="身份证号码">
							<a-input v-model="upform.tCard" placeholder="请输入身份证号码" />
						</a-form-model-item>
						<a-form-model-item ref="tSchool" prop="tSchool" label="毕业学校">
							<a-input v-model="upform.tSchool" placeholder="请输入毕业学校" />
						</a-form-model-item>
						<a-form-model-item ref="tYear" prop="tYear" label="毕业年份">
							<a-input v-model="upform.tYear" placeholder="请输入毕业年份" />
						</a-form-model-item>
						<a-form-model-item ref="tEducation" prop="tEducation" label="学历">
							<a-select v-model="upform.tEducation" placeholder="请选择">
								<a-select-option value="0">
									大专
								</a-select-option>
								<a-select-option value="1">
									本科
								</a-select-option>
								<a-select-option value="2">
									硕士
								</a-select-option>
								<a-select-option value="3">
									博士
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="tDegree" prop="tDegree" label="学位">
							<a-select v-model="upform.tDegree" placeholder="请选择">
								<a-select-option value="0">
									学士
								</a-select-option>
								<a-select-option value="1">
									硕士
								</a-select-option>
								<a-select-option value="2">
									博士
								</a-select-option>
								<a-select-option value="3">
									院士
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="tMajor" prop="tMajor" label="专业">
							<a-input v-model="upform.tMajor" placeholder="请输入专业" />
						</a-form-model-item>
						<a-form-model-item ref="tFettle" prop="tFettle" label="状态">
							<a-select v-model="upform.tFettle" placeholder="请选择">
								<a-select-option value="0">
									在职
								</a-select-option>
								<a-select-option value="1">
									离职
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="tRemark" prop="tRemark" label="备注">
							<a-input v-model="upform.tRemark" placeholder="请输入备注" />
						</a-form-model-item>
						<a-form-model-item :wrapper-col="{ span: 12, offset: 20 }">
							<a-button type="primary" @click="editSubmit">
								提交
							</a-button>
						</a-form-model-item>
					</a-form-model>
				</a-modal>
			</a-button>
			<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
				@click="delstu(record.tNo)">删除</a-button>
			<a-button slot="action" slot-scope="text,record" size="small" type="dashed" icon="search"
				@click="selectFclass(record.tId)">查看
				<a-modal title="授课班级" :visible="Onselect" @cancel="selectCancels" :footer='null'>
					<div v-infinite-scroll="handleInfiniteOnLoad" class="demo-infinite-container"
						:infinite-scroll-disabled="busy" :infinite-scroll-distance="10">
						<a-list :data-source="data">
							<a-list-item slot="renderItem" slot-scope="item, index">
								<a-list-item-meta :description="item.course.cName">
									<a slot="title" :href="item.href">{{ item.fclass.classname }}</a>
								</a-list-item-meta>
								<div>班级人数：{{item.fclass.cNumber}}</div>
							</a-list-item>
							<div v-if="loading && !busy" class="demo-loading-container">
								<a-spin />
							</div>
						</a-list>
					</div>
				</a-modal>
			</a-button>
		</a-table>
	</div>

</template>
<script>
	import reqwest from 'reqwest';
	import infiniteScroll from 'vue-infinite-scroll';
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'tId',
			key: 'tId',
			fixed: 'left'
		},
		{
			title: '教师姓名',
			width: 100,
			align: 'center',
			dataIndex: 'tName',
			key: 'tName',
			fixed: 'left'
		},
		{
			title: '教师编号',
			width: 100,
			align: 'center',
			dataIndex: 'tNo',
			key: 'tNo',
		},
		{
			title: '性别',
			dataIndex: 'tGender',
			key: '1',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'tGender'
			},
		},
		{
			title: '电话',
			dataIndex: 'tPhone',
			key: '2',
			width: 150,
			align: 'center',
		},
		{
			title: '邮箱',
			dataIndex: 'tEmail',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '出生日期',
			dataIndex: 'tBirthday',
			key: '4',
			width: 150,
			align: 'center',
		},
		{
			title: '身份证号码',
			dataIndex: 'tCard',
			key: '5',
			width: 150,
			align: 'center',
		},
		{
			title: '毕业学校',
			dataIndex: 'tSchool',
			key: '6',
			width: 150,
			align: 'center',
		},
		{
			title: '毕业年份',
			dataIndex: 'tYear',
			key: '7',
			width: 150,
			align: 'center',
		},
		{
			title: '学历',
			dataIndex: 'tEducation',
			key: '8',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'tEducation'
			},
		},
		{
			title: '学位',
			dataIndex: 'tDegree',
			key: '9',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'tDegree'
			},
		},
		{
			title: '专业',
			dataIndex: 'tMajor',
			key: '10',
			width: 150,
			align: 'center',
		},
		{
			title: '状态',
			dataIndex: 'tFettle',
			key: '11',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'tFettle'
			},
		},
		{
			title: '备注',
			dataIndex: 'tRemark',
			key: '12',
			align: 'center',
		},
		{
			title: '操作',
			key: 'operation2',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作',
			key: 'operation3',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action3'
			},
		},
		{
			title: '操作',
			key: 'operation',
			fixed: 'right',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action'
			},
		},
	];

	const dataSource = [{
		tId: '1',
	}];
	export default {
		inject: ['reload'],
		directives: {
			infiniteScroll
		},
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource,
				data: [],
				loading: false,
				busy: false,
				columns,
				visible: false,
				visibles: false,
				Onselect: false,
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
				upform: {
					tId: '',
					tNo: '',
					tName: '',
					tGender: '',
					tPhone: '',
					tEmail: '',
					tBirthday: '',
					tCard: '',
					tSchool: '',
					tYear: '',
					tEducation: '',
					tDegree: '',
					tMajor: '',
					tFettle: '',
					tRemark: '',
				},
				rules: {
					tNo: [{
						required: false,
						message: '请输入修改的编号',
						trigger: 'blur'
					}],
					tName: [{
						required: true,
						message: '请输入修改的姓名',
						trigger: 'blur'
					}],
					tGender: [{
						required: true,
						message: '请输入修改的性别',
						trigger: 'blur'
					}],
					tPhone: [{
						required: true,
						message: '请输入修改的电话号码',
						trigger: 'blur'
					}, {
						min: 11,
						max: 11,
						message: '请输入11位正确格式电话号码',
						trigger: 'blur'
					}],
					tEmail: [{
						required: true,
						message: '请输入修改的邮箱',
						trigger: 'blur'
					}, {
						type: 'email',
						message: '请输入正确格式邮箱XXX@XX.com',
						trigger: 'blur'
					}],
					tBirthday: [{
						required: true,
						message: '请输入修改的出生日期',
						trigger: 'blur'
					}, ],
					tCard: [{
						required: true,
						message: '请输入修改的身份证号码',
						trigger: 'blur'
					}, {
						min: 18,
						max: 18,
						message: '请输入18位正确格式身份证号码',
						trigger: 'blur'
					}],
					tSchool: [{
						required: true,
						message: '请输入修改的毕业学校',
						trigger: 'blur'
					}],
					tYear: [{
						required: true,
						message: '请输入修改的毕业年份',
						trigger: 'blur'
					}],
					tEducation: [{
						required: true,
						message: '请输入修改的学历',
						trigger: 'blur'
					}],
					tDegree: [{
						required: true,
						message: '请输入修改的学位',
						trigger: 'blur'
					}],
					tMajor: [{
						required: true,
						message: '请输入修改的专业',
						trigger: 'blur'
					}],
					tFettle: [{
						required: true,
						message: '请输入修改的状态',
						trigger: 'blur'
					}],
					tRemark: [{
						required: false,
						message: '请输入修改的备注',
						trigger: 'blur'
					}],
				},
			};
		},
		created() {
			this.teacherload()
		},
		methods: {
			handleInfiniteOnLoad() {
				const data = this.data;
				this.loading = true;
				if (data.length > 14) {
					this.$message.warning('Infinite List loaded all');
					this.busy = true;
					this.loading = false;
					return;
				}
			},
			selectFclass(id) {
				request.post('/api/admin/teacher/fclass', id)
					.then(res => {
						this.data = res.data
					})
				this.Onselect = true
			},
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
			selectCancels(e) {
				this.Onselect = false
			},
			teacherload() {
				request.post('/api/admin/teacher/select')
					.then(res => {
						console.log(res.data)
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			addSubmit() {
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						request.post('/api/admin/teacher/add', datas)
							.then(res => {
								if (res.code == "100") {
									this.$message.error("新增教师用户失败")
								} else if (res.code == "0") {
									this.$message.success("添加成功！")
									this.form.resetFields();
									this.reload(); //刷新
								}
							})
					}
				});
			},
			editSubmit() {
				this.$refs.ruleForm.validate(valid => {
					if (valid) {
						request.post('/api/admin/teacher/update', this.upform)
							.then(res => {
								this.$message.success("修改成功！")
								this.reload(); //刷新
							})
							.catch(error => {
								this.$message.error("修改失败！")
								this.reload(); //刷新
							})
					} else {
						console.log('error submit!!');
						return false;
					}
				});

			},
			// 删除
			delstu(id) {
				console.log(id)
				//const sid = id
				request.delete('/api/admin/teacher/delete/' + id)
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
<style scoped>
	.ant-form {
		width: 100%;
		display: flex;
		/* flex-flow:wrap 规定灵活的项目在必要的时候拆行或拆列。 */
		flex-wrap: wrap;
	}

	.ant-form-item {
		width: 50%;
	}

	.demo-infinite-container {
		border: 1px solid #e8e8e8;
		border-radius: 4px;
		overflow: auto;
		padding: 8px 24px;
		height: 300px;
	}

	.demo-loading-container {
		position: absolute;
		bottom: 40px;
		width: 100%;
		text-align: center;
	}
</style>
