<template>
	<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1650, y: 385 }" :pagination="paginationOpt"
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
			<span v-if="record.hFettle ==0">烈士家庭</span>
			<span v-if="record.hFettle ==1">单亲家庭</span>
			<span v-if="record.hFettle ==2">正常</span>
		</span>
		
		
		<a-button slot="action1" slot-scope="text,record" size="small" @click="showModal()" type="primary"
			icon="plus-square">
			新增
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<Houseform />
			</a-modal>
		</a-button>
		
		<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
			<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
				<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit()">
					<a-form-item label="学生标识">
						<a-input v-model:value="upform.sId" v-decorator="['sId', { rules: [{ required: true, message: '学生标识不能为空'}]}]"
							placeholder="请输入学生标识" />
					</a-form-item>
					<a-form-item label="与学生关系">
						<a-select v-model:value="upform.genre" v-decorator="['genre',{ rules: [{ required: true, message: '成员类型不能为空' }] },
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
						<a-input v-model:value="upform.hName" v-decorator="['hName', { rules: [{ required: true, message: '成员姓名不能为空'}]}]"
							placeholder="请输入成员姓名" />
					</a-form-item>
					<a-form-item label="性别">
						<a-select v-model:value="upform.hGender" v-decorator="['hGender',{ rules: [{ required: true, message: '性别不能为空' }] },]" placeholder="选择性别">
							<a-select-option value="1">
								男
							</a-select-option>
							<a-select-option value="0">
								女
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="电话">
						<a-input v-model:value="upform.hPhone" v-decorator="['hPhone', { rules: [{ required: true, message: '电话不能为空'}]}]"
							placeholder="请输入电话" />
					</a-form-item>
					<a-form-item label="出生日期" style="margin-bottom:0;">
					    <a-date-picker v-model:value="upform.hBirthday" v-decorator="['hBirthday', { rules: [{ required: true, message: '出生日期不能为空' }] }]" style="width: 100%" />
					</a-form-item>
					<a-form-item label="身份证号码">
						<a-input v-model:value="upform.hCard" v-decorator="['hCard', { rules: [{ required: true, message: '身份证号码不能为空'}]}]"
							placeholder="请输入身份证号码" />
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-model:value="upform.hFettle" v-decorator="[
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
						<a-input v-model:value="upform.hRemark" v-decorator="['hRemark', { rules: [{ required: false}]}]"
							placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form-model>
			</a-modal>
		</a-button>
		<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
			@click="delstu(record.hId)">删除</a-button>
	</a-table>
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
			};
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
			editSubmit(){
				request.post('/api/admin/house/updata',this.upform)
				.then(res =>{
					this.$message.success("修改成功!!")
					this.reload(); //刷新
				})
				.catch(error =>{
					this.$message.error("修改失败!!")
					this.reload();  //刷新
				})
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
						this.reload();  //刷新
					})
			},
		},
		components: {
			Houseform,
		}
	};
</script>
