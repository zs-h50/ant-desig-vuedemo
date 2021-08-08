<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1850, y: 385 }" :pagination="paginationOpt" row-key="tId">
		<span slot="tGender" slot-scope="text,record" >
			<span v-if="record.tGender == 0">女</span>
			<span v-if="record.tGender == 1">男</span>
		</span>
		<span slot="tEducation" slot-scope="text,record" >
			<span v-if="record.tEducation == 0">大专</span>
			<span v-if="record.tEducation == 1">本科</span>
			<span v-if="record.tEducation == 2">硕士</span>
			<span v-if="record.tEducation == 3">博士</span>
		</span>
		<span slot="tDegree" slot-scope="text,record" >
			<span v-if="record.tDegree == 0">学士</span>
			<span v-if="record.tDegree == 1">硕士</span>
			<span v-if="record.tDegree == 2">博士</span>
			<span v-if="record.tDegree == 3">院士</span>
		</span>
		<span slot="tFettle" slot-scope="text,record" >
			<span v-if="record.tFettle == 0">在职</span>
			<span v-if="record.tFettle == 1">离职</span>
		</span>
		<a-button slot="action" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
		<a-modal title="修改" width="70%" :visible="visibles" :footer="null" @cancel="handleCancels" >
			<!-- 放个表单 -->
			<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit">
				<a-form-model-item  ref="tNo" prop="tNo" label="教师编号">
					<a-input disabled v-model="upform.tNo" placeholder="请输入教师编号" />
				</a-form-model-item>
				<a-form-model-item ref="tName" prop="tName" label="教师姓名">
					<a-input disabled v-model="upform.tName" v-decorator="['tName',{ rules: [{ required: true, message: '教师姓名不能为空' }] },
				]" placeholder="请输入教师姓名"></a-input>
				</a-form-model-item>
				<a-form-model-item ref="tGender" prop="tGender" label="性别">
					<a-select disabled v-model="upform.tGender"  placeholder="选择性别">
						<a-select-option value="1">
							男
						</a-select-option>
						<a-select-option value="0">
							女
						</a-select-option>
					</a-select>
				</a-form-model-item>
				<a-form-model-item ref="tPhone" prop="tPhone" label="电话">
					<a-input v-model="upform.tPhone"	placeholder="请输入电话" />
				</a-form-model-item>
				<a-form-model-item ref="tEmail" prop="tEmail" label="邮箱">
					<a-input v-model="upform.tEmail" 	placeholder="请输入邮箱" />
				</a-form-model-item>
				<a-form-model-item ref="tBirthday" prop="tBirthday" label="出生日期" style="margin-bottom:0;">
				    <a-date-picker v-model="upform.tBirthday" style="width: 100%" />
				</a-form-model-item>
				<a-form-model-item ref="tCard" prop="tCard" label="身份证号码">
					<a-input disabled v-model="upform.tCard" placeholder="请输入身份证号码" />
				</a-form-model-item>
				<a-form-model-item ref="tSchool" prop="tSchool" label="毕业学校">
					<a-input disabled v-model="upform.tSchool" placeholder="请输入毕业学校" />
				</a-form-model-item>
				<a-form-model-item ref="tYear" prop="tYear" label="毕业年份">
					<a-input disabled v-model="upform.tYear"	placeholder="请输入毕业年份" />
				</a-form-model-item>
				<a-form-model-item ref="tEducation" prop="tEducation" label="学历">
					<a-select disabled v-model="upform.tEducation" placeholder="请选择">
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
					<a-select disabled v-model="upform.tDegree" placeholder="请选择">
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
					<a-input disabled v-model:value="upform.tMajor" placeholder="请输入专业" />
				</a-form-model-item>
				<a-form-model-item ref="tFettle" prop="tFettle" label="状态">
					<a-select disabled v-model="upform.tFettle" placeholder="请选择">
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
					<a-button type="primary" html-type="submit">
						提交
					</a-button>
				</a-form-model-item>
			</a-form-model>
		</a-modal>
		</a-button>
	</a-table>
</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'tId',
			key: 'tId',
		},
		{
			title: '教师姓名',
			width: 100,
			align: 'center',
			dataIndex: 'tName',
			key: 'tName',
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
			width: 100,
			dataIndex: 'tRemark',
			key: '12',
			align: 'center',
		},
		{
			title: '操作',
			key: 'operation',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action'
			},
		},
	];

	const dataSource = [{
		tId: '1',
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource,
				columns,
				visibles: false,
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				upform:{
					tId:'',
					tNo:'',
					tName:'',
					tGender:'',
					tPhone:'',
					tEmail:'',
					tBirthday:'',
					tCard:'',
					tSchool:'',
					tYear:'',
					tEducation:'',
					tDegree:'',
					tMajor:'',
					tFettle:'',
					tRemark:'',
				},
				dates:'',
				rules:{
					tPhone: [
					{
						required: true,
						message: '请输入修改的电话号码',
						trigger: 'blur'
					},
					{
						min:11,
						max:11,
						message: '请输入11位格式的电话号码',
					},
					],
					tEmail:[{
						required: true,
						message: '请输入修改的邮箱号',
						trigger: 'blur'
					},{
						type:'email',
						message: '请输入正确格式的邮箱号，如XX.@XX.com',
					}],
					tBirthday:[{
						required: true,
						message: '请输入修改的出生日期',
						trigger: 'blur'
					}]
				},
			};
		},
		created() {
			const user = sessionStorage.getItem("user");
			const users = JSON.parse(user);
			this.dates = users.account; 
			//sessionStorage.setItem("teacher",JSON.stringify(res.data))
			this.teacherload()
		},
		methods:{
			enditModal(record){
				this.upform = JSON.parse(JSON.stringify(record))
				this.visibles = true
			},
			handleCancels(e) {
				this.visibles = false;
			},
			teacherload(){
				console.log(this.dates)
				request.post('/api/admin/teacher/select/one',this.dates)
				.then(res =>{
					//console.log(this.dates)
					console.log(res.data)
					//this.dataSource.classname = res.data.fclass.classname
					this.dataSource = res.data
					//this.reload();  //刷新
				})
				.catch(error =>{
					this.$message.error("查询错误！！")
				})
			},
			editSubmit(){
				request.post('/api/admin/teacher/update',this.upform)
				.then(res =>{
					this.$message.success("修改成功！")
					this.reload();  //刷新
				})
				.catch(error => {
					this.$message.error("修改失败！")
					this.reload();  //刷新
				})
			},
		},
	};
</script>
<style scoped>
	.ant-form {
		width: 100%;
		display: flex;
		/* flex-flow:wrap 规定灵活的项目在必要的时候拆行或拆列。 */
		flex-flow: wrap;
	}
	
	.ant-form-item {
		width: 50%;
	}
</style>