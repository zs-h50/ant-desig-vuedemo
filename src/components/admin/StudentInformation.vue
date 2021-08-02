<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 3100, y: 385 }" :pagination="paginationOpt" row-key="sId">
		<!-- <a slot="action" slot-scope="text">action</a> -->
			<a-button slot="action1"  slot-scope="text" size="small" @click="showModal()" type="primary" icon="plus-square">
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
			
		<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="editModal(record)">编辑
		<a-modal
		      title="修改"
		      :visible="visible"
			  :footer="null"
		      @cancel="handleCancel"
		    >
			<a-form :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmit">
				<a-form-item label="姓名">
					<a-input v-model:value="upfrom.sName" v-decorator="['sName', { rules: [{ required: true, message: '学生姓名不能为空'}]}]" placeholder="请输入学生的姓名" />
				</a-form-item>
				<a-form-item label="学号">
					<a-input v-model:value="upfrom.sNo" v-decorator="['sNo', { rules: [{ required: true, message: '学生学号不能为空' }] }]" placeholder="请输入学生的学号" />
				</a-form-item>
				<a-form-item label="性别">
					<a-select v-model:value="upfrom.gender" v-decorator="[
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
					<a-input v-model:value="upfrom.sPhone" v-decorator="['sPhone', { rules: [{ required: true, message: '学生联系方式不能为空' }] }]" placeholder="请输入学生的联系方式" />
				</a-form-item>
				<a-form-item label="邮箱">
					<a-input v-model:value="upfrom.email" v-decorator="['email', { rules: [{ required: true, message: '学生邮箱不能为空' }] }]" placeholder="请输入学生的邮箱方式" />
				</a-form-item>
				<!-- 出生日期 -->
				<a-form-item label="出生日期" style="margin-bottom:0;">
				    <a-date-picker v-model:value="upfrom.birthday" v-decorator="['birthday', { rules: [{ required: true, message: '学生出生日期不能为空' }] }]" style="width: 100%" />
				</a-form-item>
				<a-form-item label="身份证号">
					<a-input v-model:value="upfrom.idCard" v-decorator="['idCard', { rules: [{ required: true, message: '学生身份证号不能为空' }] }]" placeholder="请输入学生的身份证号" />
				</a-form-item>
				<a-form-item label="联系人">
					<a-input v-model:value="upfrom.contact" v-decorator="['contact', { rules: [{ required: true, message: '学生联系人不能为空' }] }]" placeholder="请输入学生的联系人" />
				</a-form-item>
				<a-form-item label="联系人方式">
					<a-input v-model:value="upfrom.contactphone" v-decorator="['contactphone', { rules: [{ required: true, message: '学生联系人方式不能为空' }] }]" placeholder="请输入学生的联系人方式" />
				</a-form-item>
				<a-form-item label="住址">
					<a-input v-model:value="upfrom.address" v-decorator="['address', { rules: [{ required: true, message: '学生住址不能为空' }] }]" placeholder="请输入学生的住址" />
				</a-form-item>
				<a-form-item label="邮编">
					<a-input v-model:value="upfrom.postcode" v-decorator="['postcode', { rules: [{ required: true, message: '学生邮编不能为空' }] }]" placeholder="请输入学生的邮编" />
				</a-form-item>
				<a-form-item label="家庭状况">
					<a-input v-model:value="upfrom.situation" v-decorator="['situation', { rules: [{ required: false}] }]" placeholder="请输入学生的家庭状况" />
				</a-form-item>
				<a-form-item label="父亲姓名">
					<a-input v-model:value="upfrom.father" v-decorator="['father', { rules: [{ required: false, message: '学生父亲姓名不能为空' }] }]" placeholder="请输入学生的父亲姓名" />
				</a-form-item>
				<a-form-item label="父亲电话">
					<a-input v-model:value="upfrom.fatherphone" v-decorator="['fatherphone', { rules: [{ required: false, message: '学生父亲电话不能为空' }] }]" placeholder="请输入学生的父亲电话" />
				</a-form-item>
				<a-form-item label="母亲姓名">
					<a-input v-model:value="upfrom.mather" v-decorator="['mather', { rules: [{ required: false, message: '学生母亲姓名不能为空' }] }]" placeholder="请输入学生的母亲姓名" />
				</a-form-item>
				<a-form-item label="母亲电话">
					<a-input v-model:value="upfrom.matherphone" v-decorator="['matherphone', { rules: [{ required: false, message: '学生母亲电话不能为空' }] }]" placeholder="请输入学生的母亲电话" />
				</a-form-item>
				<a-form-item label="就学状态">
					<a-select v-model:value="upfrom.fettle" v-decorator="[
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
					<a-input v-model:value="upfrom.remark" v-decorator="['remark', { rules: [{ required: false}] }]" placeholder="备注" />
				</a-form-item>
				<a-form-item label="班级标识">
					<a-input v-model:value="upfrom.cId"  v-decorator="['cId', { rules: [{ required: true, message: '学生班级标识不能为空' }] }]" placeholder="班级标识" />
				</a-form-item>
				<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
					<a-button type="primary" html-type="submit">
						提交
					</a-button>
				</a-form-item>
			</a-form>
		</a-modal>
		</a-button>
		<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete" @click="delstu(record.sId)">删除</a-button>
	</a-table>
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
			title: '性别',
			dataIndex: 'gender',
			key: '1',
			width: 150,
			align: 'center',
		},
		{
			title: '联系方式',
			dataIndex: 'sPhone',
			key: '2',
			width: 150,
			align: 'center',
		},
		{
			title: '邮箱',
			dataIndex: 'email',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '出生日期',
			dataIndex: 'birthday',
			key: '4',
			width: 150,
			align: 'center',
		},
		{
			title: '身份证号码',
			dataIndex: 'idCard',
			key: '5',
			width: 150,
			align: 'center',
		},
		{
			title: '联系人',
			dataIndex: 'contact',
			key: '6',
			width: 150,
			align: 'center',
		},
		{
			title: '联系人方式',
			dataIndex: 'contactphone',
			key: '7',
			width: 150,
			align: 'center',
		},
		{
			title: '住址',
			dataIndex: 'address',
			key: '8',
			width: 150,
			align: 'center',
		},
		{
			title: '邮编',
			dataIndex: 'postcode',
			key: '9',
			width: 150,
			align: 'center',
		},
		{
			title: '家庭状况',
			dataIndex: 'situation',
			key: '10',
			width: 150,
			align: 'center',
		},
		{
			title: '父亲名称',
			dataIndex: 'father',
			key: '11',
			width: 150,
			align: 'center',
		},
		{
			title: '父亲电话',
			dataIndex: 'fatherphone',
			key: '12',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲姓名',
			dataIndex: 'mather',
			key: '13',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲电话',
			dataIndex: 'matherphone',
			key: '14',
			width: 150,
			align: 'center',
		},
		{
			title: '当前状态',
			dataIndex: 'fettle',
			key: '15',
			width: 150,
			align: 'center',
		},
		{
			title: '备注',
			dataIndex: 'remark',
			key: '16',
			width: 150,
			align: 'center',
		},
		{
			title: '班级名称',
			dataIndex: 'fclass.classname',
			key: '17',
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
		sId: "1",

	}]
	export default {
		data() {
			return {
				dataSource,
				columns,
				visible: false,
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				upfrom:{
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
				this.upfrom = JSON.parse(JSON.stringify(record)) 
				this.visible = true;
			},
			handleCancel(e) {
				// console.log('Clicked cancel button');
				this.visible = false;
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
