<template>
	<div>
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 3000, y: 385 }" :pagination="paginationOpt" row-key="sId">
			
			<span slot="gender" slot-scope="text,record">
				<span v-if="record.gender == 0">女</span>
				<span v-if="record.gender == 1">男</span>
			</span>
			
			<span slot="fettle" slot-scope="text,record">
				<span v-if="record.fettle == 1">在读</span>
				<span v-if="record.fettle == 2">休学</span>
				<span v-if="record.fettle == 3">退学</span>
			</span>
			<span slot="father" slot-scope="text,record" v-if="record.houseHold.genre == 4">
				<span>{{record.houseHold.hName}}</span>
			</span>
			<span slot="fatherphone" slot-scope="text,record" v-if="record.houseHold.genre == 4">
				{{record.houseHold.hPhone}}
			</span>
			<span slot="mather" slot-scope="text,record" v-if="record.houseHold.genre == 5">
				{{record.houseHold.hName}}
			</span>
			<span slot="matherphone" slot-scope="text,record" v-if="record.houseHold.genre == 5">
				<span>{{record.houseHold.hPhone}}</span>
			</span>
			<!-- <a slot="action" slot-scope="text">action</a> -->
		
				
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="editModal(record)">编辑
				<a-modal
				      title="修改"
				      :visible="visibles"
					  :footer="null"
					  width="70%"
					  @cancel="handleCancels"
				    >
					<a-form-model :form="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit">
						<a-form-model-item label="姓名">
							<a-input disabled v-model="upform.sName"  placeholder="请输入学生的姓名" />
						</a-form-model-item>
						<a-form-model-item label="学号">
							<a-input disabled v-model="upform.sNo" placeholder="请输入学生的学号" />
						</a-form-model-item>
						<a-form-model-item label="性别">
							<a-select disabled v-model="upform.gender" placeholder="选择学生的性别">
								<a-select-option value="1">
									男
								</a-select-option>
								<a-select-option value="0">
									女
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="sPhone" prop="sPhone" label="联系方式">
							<a-input v-model="upform.sPhone" placeholder="请输入学生的联系方式" />
						</a-form-model-item>
						<a-form-model-item ref="email" prop="email" label="邮箱">
							<a-input v-model="upform.email" placeholder="请输入学生的邮箱方式" />
						</a-form-model-item>
						<!-- 出生日期 -->
						<a-form-model-item ref="birthday" prop="birthday" label="出生日期" style="margin-bottom:0;">
						    <a-date-picker v-model="upform.birthday" style="width: 100%" />
						</a-form-model-item>
						<a-form-model-item label="身份证号">
							<a-input disabled v-model="upform.idCard" placeholder="请输入学生的身份证号" />
						</a-form-model-item>
						<a-form-model-item ref="contact" prop="contact" label="联系人">
							<a-input v-model="upform.contact"  placeholder="请输入学生的联系人" />
						</a-form-model-item>
						<a-form-model-item ref="contactphone" prop="contactphone" label="联系人方式">
							<a-input v-model="upform.contactphone" placeholder="请输入学生的联系人方式" />
						</a-form-model-item>
						<a-form-model-item ref="address" prop="address" label="住址">
							<a-input v-model="upform.address" placeholder="请输入学生的住址" />
						</a-form-model-item>
						<a-form-model-item ref="postcode" prop="postcode" label="邮编">
							<a-input v-model="upform.postcode" placeholder="请输入学生的邮编" />
						</a-form-model-item>
						<a-form-model-item ref="situation" prop="situation" label="家庭状况">
							<a-input v-model="upform.situation" placeholder="请输入学生的家庭状况" />
						</a-form-model-item>
						<a-form-model-item label="父亲姓名">
							<a-input disabled v-model="upform.father" placeholder="请输入学生的父亲姓名" />
						</a-form-model-item>
						<a-form-model-item label="父亲电话">
							<a-input disabled v-model="upform.fatherphone" placeholder="请输入学生的父亲电话" />
						</a-form-model-item>
						<a-form-model-item label="母亲姓名">
							<a-input disabled v-model="upform.mather" placeholder="请输入学生的母亲姓名" />
						</a-form-model-item>
						<a-form-model-item label="母亲电话">
							<a-input disabled v-model="upform.matherphone" placeholder="请输入学生的母亲电话" />
						</a-form-model-item>
						<a-form-model-item label="就学状态">
							<a-select disabled v-model="upform.fettle"  placeholder="选择类型">
								<a-select-option value="1">
									在读
								</a-select-option>
								<a-select-option value="2">
									休学
								</a-select-option>
								<a-select-option value="3">
									退学
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item label="备注">
							<a-input v-model="upform.remark" placeholder="备注" />
						</a-form-model-item>
						<a-form-model-item label="班级标识">
							<a-input disabled v-model:value="upform.cId" placeholder="班级标识" />
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
	</div>
	
</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'sId',
			key: 'sId',
			fixed: 'left'
		},
		{
			title: '姓名',
			width: 100,
			align: 'center',
			dataIndex: 'sName',
			key: 'sName',
			fixed: 'left'
		},
		{
			title: '学号',
			width: 100,
			align: 'center',
			dataIndex: 'sNo',
			key: 'sNo',
		},
		{
			title: '班级名称',
			dataIndex: 'fclass.classname',
			key: '1',
			align: 'center',
		},
		{
			title: '性别',
			dataIndex: 'gender',
			key: '2',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'gender'
			},
		},
		{
			title: '联系方式',
			dataIndex: 'sPhone',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '邮箱',
			dataIndex: 'email',
			key: '4',
			width: 150,
			align: 'center',
		},
		{
			title: '出生日期',
			dataIndex: 'birthday',
			key: '5',
			width: 150,
			align: 'center',
		},
		{
			title: '身份证号码',
			dataIndex: 'idCard',
			key: '6',
			width: 150,
			align: 'center',
		},
		{
			title: '联系人',
			dataIndex: 'contact',
			key: '7',
			width: 150,
			align: 'center',
		},
		{
			title: '联系人方式',
			dataIndex: 'contactphone',
			key: '8',
			width: 150,
			align: 'center',
		},
		{
			title: '住址',
			dataIndex: 'address',
			key: '9',
			width: 150,
			align: 'center',
		},
		{
			title: '邮编',
			dataIndex: 'postcode',
			key: '10',
			width: 150,
			align: 'center',
		},
		{
			title: '家庭状况',
			dataIndex: 'situation',
			key: '11',
			width: 150,
			align: 'center',
		},
		{
			title: '父亲名称',
			dataIndex: 'houseHold.hName',
			key: '12',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'father'
			},
		},
		{
			title: '父亲电话',
			dataIndex: 'houseHold.hPhone',
			key: '13',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'fatherphone'
			},
		},
		{
			title: '母亲姓名',
			dataIndex: 'houseHold.hName',
			key: '14',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'mather'
			},
		},
		{
			title: '母亲电话',
			dataIndex: 'houseHold.hPhone',
			key: '15',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'matherphone'
			},
		},
		{
			title: '当前状态',
			dataIndex: 'fettle',
			key: '16',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'fettle'
			},
		},
		{
			title: '备注',
			dataIndex: 'remark',
			key: '17',
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
	];
	const dataSource = [{
		sId: "1",

	}]
	export default {
		inject: ['reload'],
		data() {
			return {
				dataSource,
				columns,
				dates:'',
				visibles: false,
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				upform:{
					sName:'',
					sNo:'',
					gender:'',
					sPhone:'',
					email:'',
					birthday:'',
					idCard:'',
					contact:'',
					contactphone:'',
					address:'',
					postcode:'',
					father:'',
					fatherphone:'',
					mather:'',
					matherphone:'',
					fettle:'',
					remark:'',
					cId:'',
					situation:''
				},
				rules:{
					sPhone:[
						{
							required: true,
							message: '请输入修改的电话号码',
							trigger: 'blur'
						},
						{
							min:11,
							len:11,
							message: '请输入正确的11位格式电话号码'
						}
					],
					email:[
						{
							required: true,
							message: '请输入修改的邮箱',
							trigger: 'blur'
						},
						{
							type:'email',
							message: '请输入正确的邮箱格式，如XX.@XX.com'
						}
					],
					birthday:[
						{
							required: true,
							message: '请输入修改的出生日期',
							trigger: 'blur'
						}
					],
					contact:[
						{
							required: true,
							message: '请输入修改的联系人',
							trigger: 'blur'
						}
					],
					contactphone:[
						{
							required: true,
							message: '请输入修改的联系人方式',
							trigger: 'blur'
						},
						{
							min:11,
							len:11,
							message: '请输入正确的11位格式电话号码'
						}
					],
					address:[
						{
							required: true,
							message: '请输入修改的地址',
							trigger: 'blur'
						}
					],
					postcode:[
						{
							required: true,
							message: '请输入修改的邮编',
							trigger: 'blur'
						}
					]
				},
				
			};
		},
		created() {
			const user = sessionStorage.getItem("user");
			const users = JSON.parse(user);
			this.dates = users.account; 
			//sessionStorage.setItem("teacher",JSON.stringify(res.data))
			this.studentload()
		},
		methods: {
			editModal(record){
				this.visibles = true;
				this.upform = JSON.parse(JSON.stringify(record)) 
				console.log(this.upform)
			},
			handleCancels(e) {
				// console.log('Clicked cancel button');
				this.visibles = false;
			},
			// 查询学生信息
			studentload(){
				console.log(this.dates)
				request.post('/api/student/select',this.dates)
				.then(res =>{
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
				request.post('/api/student/update',this.upform)
				.then(res =>{
					this.$message.success("修改成功成功!!");
					this.reload();  //刷新
				})
				.catch(error =>{
					this.$message.error("修改失败!!")
					//this.reload();  //刷新
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
