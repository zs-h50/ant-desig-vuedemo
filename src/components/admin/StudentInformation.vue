<template>
	<a-table :columns="columns" :data-source="data" :scroll="{ x: 2950, y: 385 }" row-key="sId">
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
			
		<a-button slot="action2" slot-scope="text" size="small" icon="form">编辑</a-button>
		<a-button slot="action3" slot-scope="text" size="small" type="danger" icon="delete">删除</a-button>
	</a-table>
</template>
<script>
	import AddEditFrom from './AddEditFrom.vue'
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
			title: '父亲名称',
			dataIndex: 'father',
			key: '10',
			width: 150,
			align: 'center',
		},
		{
			title: '父亲电话',
			dataIndex: 'fatherphone',
			key: '11',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲姓名',
			dataIndex: 'mather',
			key: '12',
			width: 150,
			align: 'center',
		},
		{
			title: '母亲电话',
			dataIndex: 'matherphone',
			key: '13',
			width: 150,
			align: 'center',
		},
		{
			title: '当前状态',
			dataIndex: 'fettle',
			key: '14',
			width: 150,
			align: 'center',
		},
		{
			title: '备注',
			dataIndex: 'remark',
			key: '15',
			width: 150,
			align: 'center',
		},
		{
			title: '班级名称',
			dataIndex: 'classname',
			key: '16',
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
	const data = [{
		sId: "1",

	}]
	export default {
		data() {
			return {
				data,
				columns,
				visible: false,
				ModalText: 'Content of the modal',
			};
		},
		methods: {
			showModal() {
				this.visible = true;
				//console.log(this.visible)
			},
			handleOk(e) {
				
			},
			handleCancel(e) {
				console.log('Clicked cancel button');
				this.visible = false;
			},
		},
		components: {
			AddEditFrom,
		},
	};
</script>
