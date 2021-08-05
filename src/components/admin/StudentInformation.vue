<template>
	<div>
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">
			新增
			<a-modal
			      title="新增"
			      :visible="visible"
				  :footer="null"
			      @cancel="handleCancel"
			    >
				<!-- 放个表单 -->
				<AddEditFrom />
			</a-modal>
		</a-button>
		
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 3100, y: 385 }" :pagination="paginationOpt" row-key="sId">
			<span slot="gender" slot-scope="text,record">
				<span v-if="record.gender == 0">女</span>
				<span v-if="record.gender == 1">男</span>
			</span>
			
			<span slot="fettle" slot-scope="text,record">
				<span v-if="record.fettle == 1">在读</span>
				<span v-if="record.fettle == 2">休学</span>
				<span v-if="record.fettle == 3">退学</span>
			</span>
			
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="editModal(record)">编辑
				<a-modal
					  title="修改"
					  :visible="visibles"
					  :footer="null"
					  @cancel="handleCancels"
					>
					<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 7 }" :wrapper-col="{ span: 12 }" >
						<a-form-model-item ref="sName" prop="sName" label="姓名">
							<a-input v-model="upform.sName"   placeholder="请输入学生的姓名" />
						</a-form-model-item>
						<a-form-model-item ref="sNo" prop="sNo" label="学号">
							<a-input disabled v-model="upform.sNo" placeholder="请输入学生的学号" />
						</a-form-model-item>
						<a-form-model-item ref="gender" prop="gender" label="性别">
							<a-select v-model="upform.gender"  placeholder="选择学生的性别">
								<a-select-option value="1">
									男
								</a-select-option>
								<a-select-option value="0">
									女
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="sPhone" prop="sPhone" label="联系方式">
							<a-input v-model="upform.sPhone"  placeholder="请输入学生的联系方式" />
						</a-form-model-item>
						<a-form-model-item ref="email" prop="email" label="邮箱">
							<a-input v-model="upform.email"  placeholder="请输入学生的邮箱方式" />
						</a-form-model-item>
						<!-- 出生日期 -->
						<a-form-model-item ref="birthday" prop="birthday" label="出生日期" style="margin-bottom:0;">
						    <a-date-picker v-model="upform.birthday"  style="width: 100%" />
						</a-form-model-item>
						<a-form-model-item ref="idCard" prop="idCard" label="身份证号">
							<a-input v-model="upform.idCard"  placeholder="请输入学生的身份证号" />
						</a-form-model-item>
						<a-form-model-item ref="contact" prop="contact" label="联系人">
							<a-input v-model="upform.contact"  placeholder="请输入学生的联系人" />
						</a-form-model-item>
						<a-form-model-item ref="contactphone" prop="contactphone" label="联系人方式">
							<a-input v-model="upform.contactphone"  placeholder="请输入学生的联系人方式" />
						</a-form-model-item>
						<a-form-model-item ref="address" prop="address" label="住址">
							<a-input v-model="upform.address"  placeholder="请输入学生的住址" />
						</a-form-model-item>
						<a-form-model-item ref="postcode" prop="postcode" label="邮编">
							<a-input v-model="upform.postcode"  placeholder="请输入学生的邮编" />
						</a-form-model-item>
						<a-form-model-item ref="situation" prop="situation" label="家庭状况">
							<a-input v-model="upform.situation"  placeholder="请输入学生的家庭状况" />
						</a-form-model-item>
						<a-form-model-item ref="father" prop="father" label="父亲姓名">
							<a-input v-model="upform.father"  placeholder="请输入学生的父亲姓名" />
						</a-form-model-item>
						<a-form-model-item ref="fatherphone" prop="fatherphone" label="父亲电话">
							<a-input v-model="upform.fatherphone" placeholder="请输入学生的父亲电话" />
						</a-form-model-item>
						<a-form-model-item ref="mather" prop="mather" label="母亲姓名">
							<a-input v-model="upform.mather"  placeholder="请输入学生的母亲姓名" />
						</a-form-model-item>
						<a-form-model-item ref="matherphone" prop="matherphone" label="母亲电话">
							<a-input v-model="upform.matherphone"  placeholder="请输入学生的母亲电话" />
						</a-form-model-item>
						<a-form-model-item ref="fettle" prop="fettle" label="就学状态">
							<a-select v-model="upform.fettle" placeholder="选择类型">
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
						<a-form-model-item ref="remark" prop="remark" label="备注">
							<a-input v-model="upform.remark"  placeholder="备注" />
						</a-form-model-item>
						<a-form-model-item ref="cId" prop="cId" label="班级标识">
							<a-input v-model="upform.cId" placeholder="班级标识" />
						</a-form-model-item>
						<a-form-model-item :wrapper-col="{ span: 12, offset: 10 }">
							<a-button type="primary" @click="editSubmit">
								提交
							</a-button>
						</a-form-model-item>
					</a-form-model>
				</a-modal>
			</a-button>
			
			<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete" @click="delstu(record.sNo)">删除</a-button>
		</a-table>
	</div>
	
</template>
<script>
	import AddEditFrom from './AddEditFrom.vue'
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
			dataIndex: 'father',
			key: '12',
			width: 150,
			align: 'center',
		},
		{
			title: '父亲电话',
			dataIndex: 'fatherphone',
			key: '13',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲姓名',
			dataIndex: 'mather',
			key: '14',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲电话',
			dataIndex: 'matherphone',
			key: '15',
			width: 150,
			align: 'center',
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
		sId: "1",

	}]
	export default {
		inject: ['reload'],
		data() {
			return {
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
				rules: {
					sName:[
						{required: true, message: '请输入修改的姓名', trigger: 'blur' },
					],
					sNo:[
						{required: false, message: '请输入修改的学号', trigger: 'blur' },
					],
					gender:[
						{required: true, message: '请选择', trigger: 'blur' },
					],
					sPhone:[
						{required: true, message: '请输入修改的电话号码', trigger: 'blur' },
						{ min: 11, max: 11, message: '输入11位电话号码格式', trigger: 'blur' },
					],
					email:[
						{required: true, message: '请输入修改的电话号码', trigger: 'blur' },
						{type:'email',message:'请输入正确的邮箱格式：XXX.@XX.com',trigger: 'blur'}
					],
					birthday:[
						{required: true, message: '请输入修改的日期', trigger: 'blur' },
					],
					idCard:[
						{required: true, message: '请输入修改的身份证', trigger: 'blur' },
						{ min: 18, max: 18, message: '输入18位身份证格式', trigger: 'blur' },
					],
					contact:[
						{required: true, message: '请输入修改的联系人', trigger: 'blur' },
						{ min: 3, max: 5, message: '字符在3到5之间', trigger: 'blur' },
					],
					
					contactphone:[
						{required: true, message: '请输入修改的联系人方式', trigger: 'blur' },
						{ min: 11, max: 11, message: '请输入11位的联系方式', trigger: 'blur' },
					],
					address:[
						{required: true, message: '请输入修改的地址', trigger: 'blur' },
					],
					postcode:[
						{required: true, message: '请输入修改的邮编', trigger: 'blur' },
						{ min: 6, max: 6, message: '字符长度为6', trigger: 'blur' },
					],
					fettle:[
						{required: true, message: '请输入修改的状态', trigger: 'blur' },
					],
					cId:[
						{required: true, message: '请输入修改的班级标识', trigger: 'blur' },
					],
				}
			}
		},
		created() {
			this.studentload()
		},
		methods: {
			showModal() {
				this.visible = true;
				//console.log(this.visible)
			},
			editModal(record){
				this.visibles = true;
				this.upform = JSON.parse(JSON.stringify(record)) 
				console.log(this.upform)
			},
			handleCancel(e) {
				// console.log('Clicked cancel button');
				this.visible = false;
			},
			handleCancels(e) {
				// console.log('Clicked cancel button');
				this.visibles = false;
			},
			// 查询学生信息
			studentload(){
				request.post('/api/admin/studentinfo/select')
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
				
				this.$refs.ruleForm.validate(valid => {
				        if (valid) {
				          request.post('/api/admin/studentinfo/update',this.upform)
				          .then(res =>{
				          	this.$message.success("修改成功成功!!");
				          	this.reload();  //刷新
				          })
				          .catch(error =>{
				          	this.$message.error("修改失败!!")
				          	//this.reload();  //刷新
				          })
				        } else {
				          console.log('error submit!!');
				          return false;
				        }
				      });

			},
			// 删除
			delstu(id){
				console.log(id)
				//const sid = id
				request.delete('/api/admin/studentinfo/delete/'+id)
				.then(res =>{
					this.$message.success("删除成功!!")
					this.reload();  //刷新
				})
				.catch(error =>{
					this.$message.error("删除失败!!")
					//this.reload();  //刷新
				})
			},
			
		},
		components: {
			AddEditFrom,
		},
	};
</script>
