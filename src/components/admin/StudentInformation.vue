<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 3100, y: 385 }" :pagination="paginationOpt" row-key="sId">
		<!-- <a slot="action" slot-scope="text">action</a> -->
			<a-button slot="action1"  slot-scope="text" size="small" @click="showModal()" type="primary" icon="plus-square">
				新增
				<a-modal
				      title="新增"
				      :visible="visible"
				      @ok="handleOk"
					  :footer="null"
				      @cancel="handleCancel"
				    >
					<!-- 放个表单 -->
					<AddEditFrom />
				</a-modal>
			</a-button>
			
		<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="showModal()">编辑
		<a-modal
		      title="修改"
		      :visible="visible"
		      @ok="handleOk"
			  :footer="null"
		      @cancel="handleCancel"
		    >
			<!-- 放个表单 -->
			<AddEditFrom/>
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
			handleOk(e) {
				
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
