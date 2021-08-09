<template>
	<div>
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">
			新增
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<Houseform />
			</a-modal>
		</a-button>

		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1550}" :pagination="paginationOpt"
			row-key="hId">

			<span slot="genre" slot-scope="text,record">
				<span v-if="record.genre ==0">哥哥</span>
				<span v-if="record.genre ==1">姐姐</span>
				<span v-if="record.genre ==2">妹妹</span>
				<span v-if="record.genre ==3">弟弟</span>
				<span v-if="record.genre ==4">父亲</span>
				<span v-if="record.genre ==5">母亲</span>
			</span>
			<span slot="hGender" slot-scope="text,record">
				<span v-if="record.hGender ==0">女</span>
				<span v-if="record.hGender ==1">男</span>
			</span>
			<span slot="hFettle" slot-scope="text,record">
				<span v-if="record.hFettle ==0">残疾</span>
				<span v-if="record.hFettle ==1">生病</span>
				<span v-if="record.hFettle ==2">正常</span>
			</span>




			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
					<a-form-model :form="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 5 }"
						:wrapper-col="{ span: 12 }">
						<a-form-item ref="sId" prop="sId" label="学生标识">
							<a-input v-model="upform.sId" placeholder="请输入学生标识" />
						</a-form-item>
						<a-form-item ref="genre" prop="genre" label="与学生关系">
							<a-select v-model="upform.genre" placeholder="请选择">
								<a-select-option value="0">
									哥哥
								</a-select-option>
								<a-select-option value="1">
									姐姐
								</a-select-option>
								<a-select-option value="2">
									妹妹
								</a-select-option>
								<a-select-option value="3">
									弟弟
								</a-select-option>
								<a-select-option value="4">
									父亲
								</a-select-option>
								<a-select-option value="5">
									母亲
								</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item ref="hName" prop="hName" label="姓名">
							<a-input v-model="upform.hName" placeholder="请输入成员姓名" />
						</a-form-item>
						<a-form-item ref="hGender" prop="hGender" label="性别">
							<a-select v-model="upform.hGender" placeholder="选择性别">
								<a-select-option value="1">
									男
								</a-select-option>
								<a-select-option value="0">
									女
								</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item ref="hPhone" prop="hPhone" label="电话">
							<a-input v-model="upform.hPhone" placeholder="请输入电话" />
						</a-form-item>
						<a-form-item ref="hBirthday" prop="hBirthday" label="出生日期" style="margin-bottom:0;">
							<a-date-picker v-model="upform.hBirthday" style="width: 100%" />
						</a-form-item>
						<a-form-item ref="hCard" prop="hCard" label="身份证号码">
							<a-input v-model="upform.hCard" placeholder="请输入身份证号码" />
						</a-form-item>
						<a-form-item ref="hFettle" prop="hFettle" label="状态">
							<a-select v-model="upform.hFettle" placeholder="请选择">
								<a-select-option value="0">
									烈士家庭
								</a-select-option>
								<a-select-option value="1">
									离异家庭
								</a-select-option>
								<a-select-option value="2">
									正常
								</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item ref="hRemark" prop="hRemark" label="备注">
							<a-input v-model:value="upform.hRemark" placeholder="请输入备注" />
						</a-form-item>
						<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
							<a-button type="primary" @click="editSubmit()">
								提交
							</a-button>
						</a-form-item>
					</a-form-model>
				</a-modal>
			</a-button>
			<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
				@click="delstu(record.hId)">删除</a-button>
		</a-table>
	</div>

</template>
<script>
	import request from '@/utils/request.js'
	import Houseform from './Housefrom.vue'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'hId',
			key: 'hId',
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
			title: '成员类型',
			width: 100,
			align: 'center',
			dataIndex: 'genre',
			key: 'genre',
			scopedSlots: {
				customRender: 'genre'
			},
		},
		{
			title: '成员姓名',
			dataIndex: 'hName',
			key: '1',
			width: 150,
			align: 'center',
		},
		{
			title: '性别',
			dataIndex: 'hGender',
			key: '2',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'hGender'
			},
		},
		{
			title: '电话',
			dataIndex: 'hPhone',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '出生日期',
			dataIndex: 'hBirthday',
			key: '4',
			width: 150,
			align: 'center',
		},
		{
			title: '身份证号码',
			dataIndex: 'hCard',
			key: '5',
			width: 150,
			align: 'center',
		},
		{
			title: '状态',
			dataIndex: 'hFettle',
			key: '6',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'hFettle'
			},
		},
		{
			title: '备注',
			dataIndex: 'hRemark',
			key: '7',
			width: 150,
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
	];

	const dataSource = [{
		hId: '1',
		hName: '岳不群'
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
					sId: '',
					genre: '',
					hName: '',
					hGender: '',
					hPhone: '',
					hBirthday: '',
					hCard: '',
					hFettle: '',
					hRemark: ''
				},
				rules: {
					sId: [{
						required: true,
						message: '请输入修改的学生',
						trigger: 'blur'
					}, ],
					genre: [{
						required: true,
						message: '请输入修改的成员类型',
						trigger: 'blur'
					}, ],
					hName: [{
						required: true,
						message: '请输入修改的成员姓名',
						trigger: 'blur'
					}, ],
					hGender: [{
						required: true,
						message: '请输入修改的成员性别',
						trigger: 'blur'
					}, ],
					hPhone: [{
							required: true,
							message: '请输入修改的成员电话号码',
							trigger: 'blur'
						},
						{
							min: 11,
							max: 11,
							message: '请输入正确11位的号码格式',
							trigger: 'blur'
						}
					],
					hBirthday: [{
						required: true,
						message: '请输入修改的成员出生日期',
						trigger: 'blur'
					}, ],
					hCard: [{
							required: true,
							message: '请输入修改的成员身份证',
							trigger: 'blur'
						},
						{
							min: 18,
							max: 18,
							message: '请输入18位的身份证号码',
							trigger: 'blur'
						}
					],
					hFettle: [{
						required: true,
						message: '请输入修改的家庭状态',
						trigger: 'blur'
					}, ],
					hRemark: [{
						required: true,
						message: '请输入修改的备注',
						trigger: 'blur'
					}, ],
				}
			}

		},
		created() {
			this.houseload()
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
			houseload() {
				request.post('/api/admin/house/select')
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
			editSubmit() {
				this.$refs.ruleForm.validate(valid => {
					if (valid) {
						request.post('/api/admin/house/updata', this.upform)
							.then(res => {
								this.$message.success("修改成功!!")
								this.reload(); //刷新
							})
							.catch(error => {
								this.$message.error("修改失败!!")
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
				request.delete('/api/admin/house/delete/' + id)
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
			Houseform,
		}
	};
</script>
