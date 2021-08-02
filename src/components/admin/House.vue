<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1650, y: 385 }" :pagination="paginationOpt" row-key="hId">
		<a-button slot="action1" slot-scope="text,record" size="small" @click="showModal()" type="primary" icon="plus-square">
			新增
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="houseSubmit">
					<a-form-item label="学生标识">
						<a-input v-decorator="['sId', { rules: [{ required: true, message: '学生标识不能为空'}]}]"
							placeholder="请输入学生标识" />
					</a-form-item>
					<a-form-item label="成员类型">
						<a-select v-decorator="['genre',{ rules: [{ required: true, message: '成员类型不能为空' }] },
					]" placeholder="请选择">
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
					<a-form-item label="姓名">
						<a-input v-decorator="['hName', { rules: [{ required: true, message: '成员姓名不能为空'}]}]"
							placeholder="请输入成员姓名" />
					</a-form-item>
					<a-form-item label="性别">
						<a-select v-decorator="['hGender',{ rules: [{ required: true, message: '性别不能为空' }] },]" placeholder="选择性别">
							<a-select-option value="1">
								男
							</a-select-option>
							<a-select-option value="0">
								女
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="电话">
						<a-input v-decorator="['hPhone', { rules: [{ required: true, message: '电话不能为空'}]}]"
							placeholder="请输入电话" />
					</a-form-item>
					<a-form-item label="出生日期" style="margin-bottom:0;">
					    <a-date-picker v-decorator="['hBirthday', { rules: [{ required: true, message: '出生日期不能为空' }] }]" style="width: 100%" />
					</a-form-item>
					<a-form-item label="身份证号码">
						<a-input v-decorator="['hCard', { rules: [{ required: true, message: '身份证号码不能为空'}]}]"
							placeholder="请输入身份证号码" />
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-decorator="[
					  'hFettle',
					  { rules: [{ required: true, message: '家庭状态不能为空' }] },
					]" placeholder="请选择">
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
					<a-form-item label="备注">
						<a-input v-decorator="['hRemark', { rules: [{ required: false}]}]"
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
		<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal()">编辑
		</a-button>
		<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
			@click="delstu(record.hId)">删除</a-button>
	</a-table>
</template>
<script>
	import request from '@/utils/request.js'
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
		},
		{
			title: '备注',
			dataIndex: 'hRemark',
			key: '7',
			width: 150,
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
		cId: '1',
	}, ];

	export default {
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
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
		methods:{
			showModal(){
				this.visible = true
			},
			houseSubmit(){
				
			},
			handleCancel(e) {
				this.visible = false;
			},
			houseSubmit(){
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/admin/house/add',datas)
						.then(res => {
							this.$message.success("添加成功！")
							this.form.resetFields();
							this.reload();  //刷新
						})
						.catch(error =>{
							this.$message.error("添加失败！")
							this.form.resetFields();
							//this.reload();  //刷新
						})
					}
				});
			}
		},
		components:{
			
		}
	};
</script>
