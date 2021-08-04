<template>
	<div>
		<a-button size="small" @click="showModal()" type="primary" icon="plus-square">
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
			
			<!-- <a slot="action" slot-scope="text">action</a> -->
		
				
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="editModal(record)">编辑
				<a-modal
				      title="修改"
				      :visible="visibles"
					  :footer="null"
					  @cancel="handleCancels"
				    >
					<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit">
						<a-form-item label="姓名">
							<a-input v-model:value="upform.sName" v-decorator="['sName', { rules: [{ required: true, message: '学生姓名不能为空'}]}]"  placeholder="请输入学生的姓名" />
						</a-form-item>
						<a-form-item label="学号">
							<a-input disabled v-model:value="upform.sNo" v-decorator="['sNo', { rules: [{ required: true, message: '学生学号不能为空' }] }]" placeholder="请输入学生的学号" />
						</a-form-item>
						<a-form-item label="性别">
							<a-select v-model:value="upform.gender" v-decorator="[
					      'gender',
					      { rules: [{ required: true, message: '性别不能为空' }] },
					    ]" placeholder="选择学生的性别">
								<a-select-option value="1">
									男
								</a-select-option>
								<a-select-option value="0">
									女
								</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="联系方式">
							<a-input v-model:value="upform.sPhone" v-decorator="['sPhone', { rules: [{ required: true, message: '学生联系方式不能为空' },{min:11,len:11,message: '请输入正确的格式'}] }]" placeholder="请输入学生的联系方式" />
						</a-form-item>
						<a-form-item label="邮箱">
							<a-input v-model:value="upform.email" v-decorator="['email', { rules: [{ required: true, message: '学生邮箱不能为空' },{type:'email',message: '请输入正确的格式'}] }]" placeholder="请输入学生的邮箱方式" />
						</a-form-item>
						<!-- 出生日期 -->
						<a-form-item label="出生日期" style="margin-bottom:0;">
						    <a-date-picker v-model:value="upform.birthday" v-decorator="['birthday', { rules: [{ required: true, message: '学生出生日期不能为空' }] }]" style="width: 100%" />
						</a-form-item>
						<a-form-item label="身份证号">
							<a-input v-model:value="upform.idCard" v-decorator="['idCard', { rules: [{ required: true, message: '学生身份证号不能为空' },{min:18,len:18,message: '请输入正确的格式'}] }]" placeholder="请输入学生的身份证号" />
						</a-form-item>
						<a-form-item label="联系人">
							<a-input v-model:value="upform.contact" v-decorator="['contact', { rules: [{ required: true, message: '学生联系人不能为空' }] }]" placeholder="请输入学生的联系人" />
						</a-form-item>
						<a-form-item label="联系人方式">
							<a-input v-model:value="upform.contactphone" v-decorator="['contactphone', { rules: [{ required: true, message: '学生联系人方式不能为空' },{min:11,len:11,message: '请输入正确的格式'}] }]" placeholder="请输入学生的联系人方式" />
						</a-form-item>
						<a-form-item label="住址">
							<a-input v-model:value="upform.address" v-decorator="['address', { rules: [{ required: true, message: '学生住址不能为空' }] }]" placeholder="请输入学生的住址" />
						</a-form-item>
						<a-form-item label="邮编">
							<a-input v-model:value="upform.postcode" v-decorator="['postcode', { rules: [{ required: true, message: '学生邮编不能为空' },{min:5,len:5,message: '请输入正确的格式'}] }]" placeholder="请输入学生的邮编" />
						</a-form-item>
						<a-form-item label="家庭状况">
							<a-input v-model:value="upform.situation" v-decorator="['situation', { rules: [{ required: false}] }]" placeholder="请输入学生的家庭状况" />
						</a-form-item>
						<a-form-item label="父亲姓名">
							<a-input v-model:value="upform.father" v-decorator="['father', { rules: [{ required: false, message: '学生父亲姓名不能为空' }] }]" placeholder="请输入学生的父亲姓名" />
						</a-form-item>
						<a-form-item label="父亲电话">
							<a-input v-model:value="upform.fatherphone" v-decorator="['fatherphone', { rules: [{ required: false, message: '学生父亲电话不能为空' },{min:11,len:11,message: '请输入正确的格式'}] }]" placeholder="请输入学生的父亲电话" />
						</a-form-item>
						<a-form-item label="母亲姓名">
							<a-input v-model:value="upform.mather" v-decorator="['mather', { rules: [{ required: false, message: '学生母亲姓名不能为空' }] }]" placeholder="请输入学生的母亲姓名" />
						</a-form-item>
						<a-form-item label="母亲电话">
							<a-input v-model:value="upform.matherphone" v-decorator="['matherphone', { rules: [{ required: false, message: '学生母亲电话不能为空' },{min:11,len:11,message: '请输入正确的格式'}] }]" placeholder="请输入学生的母亲电话" />
						</a-form-item>
						<a-form-item label="就学状态">
							<a-select v-model:value="upform.fettle" v-decorator="[
						  'fettle',
						  { rules: [{ required: true, message: '就学状态不能为空' }] },
						]" placeholder="选择类型">
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
						</a-form-item>
						<a-form-item label="备注">
							<a-input v-model:value="upform.remark" v-decorator="['remark', { rules: [{ required: false}] }]" placeholder="备注" />
						</a-form-item>
						<a-form-item label="班级标识">
							<a-input v-model:value="upform.cId"  v-decorator="['cId', { rules: [{ required: true, message: '学生班级标识不能为空' }] }]" placeholder="班级标识" />
						</a-form-item>
						<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
							<a-button type="primary" html-type="submit">
								提交
							</a-button>
						</a-form-item>
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
			};
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
				request.post('/api/admin/studentinfo/update',this.upform)
				.then(res =>{
					this.$message.success("修改成功成功!!");
					this.reload();  //刷新
				})
				.catch(error =>{
					this.$message.error("修改失败!!")
					//this.reload();  //刷新
				})
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
