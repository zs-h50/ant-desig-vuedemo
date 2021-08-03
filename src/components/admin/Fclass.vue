<template>
	<div>
		<a-input-search placeholder="请输入要搜索的班级名称" enter-button="搜索" size="large" class="input-search"
			@search="onSearch"/>
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 700,y:385}" row-key="cId">
			<a-button slot="action1" slot-scope="text,record" size="small" @click="showModal()" type="primary"
				icon="plus-square">增加
				<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
					<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
						<a-form-item label="班级标识">
							<a-input v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
								placeholder="请输入班级标识" />
						</a-form-item>
						<a-form-item label="班级名称">
							<a-input v-decorator="['classname', { rules: [{ required: true, message: '班级名称不能为空'}]}]"
								placeholder="请输入班级名称" />
						</a-form-item>
						<a-form-item label="班级人数">
							<a-input v-decorator="['cNumber', { rules: [{ required: true, message: '班级人数不能为空'}]}]"
								placeholder="请输入班级人数" />
						</a-form-item>
						<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
							<a-button type="primary" html-type="submit">
								提交
							</a-button>
						</a-form-item>
					</a-form>	
				</a-modal>
			</a-button>
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
					<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="editSubmit">
						<a-form-item label="班级标识">
							<a-input v-model:value="upform.cId" v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
								placeholder="请输入班级标识" />
						</a-form-item>
						<a-form-item label="班级名称">
							<a-input v-model:value="upform.classname" v-decorator="['classname', { rules: [{ required: true, message: '班级名称不能为空'}]}]"
								placeholder="请输入班级名称" />
						</a-form-item>
						<a-form-item label="班级人数">
							<a-input v-model:value="upform.cNumber" v-decorator="['cNumber', { rules: [{ required: true, message: '班级人数不能为空'}]}]"
								placeholder="请输入班级人数" />
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
				@click="delstu(record.cId)">删除</a-button>
		</a-table>
	</div>

</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: '班级标识',
			width: 100,
			dataIndex: 'cId',
			align: 'center',
			key: 'cId',
			fixed: 'left'
		},
		{
			title: '班级名称',
			width: 200,
			dataIndex: 'classname',
			align: 'center',
			key: 'classname',
			fixed: 'left'
		},
		{
			title: '班级人数',
			dataIndex: 'cNumber',
			width: 100,
			align: 'center',
			key: '1'
		},
		{
			title: '操作1',
			key: 'operation1',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action1'
			},
		},
		{
			title: '操作2',
			key: 'operation2',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作3',
			key: 'operation3',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action3'
			},
		},
	];
	const dataSource =[
		{
			cId:1
		}
	]
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
					eId: '',
					cId: '',
					tId: '',
					eYear: '',
					eSemester: '',
					eFettle: '',
					eRemark: '',
					courseId: '',
				},
				datas:'', //搜索框	
			};
		},
		created() {
			this.fclassload()
		},
		methods: {
			fclassload(){
				request.post("/api/admin/fclass/select")
				.then(res =>{
					this.dataSource = res.data
				})
				.catch(error =>{
					this.$message.error("查询失败！")
					//this.reload();
				})
			},
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
			onSearch(value) {
				this.datas = value
				console.log(value)
				request.post('/api/admin/fclass/select/search',this.datas)
				.then(res => {
					this.dataSource = res.data
				})
				.catch(error=>{
					this.$message.error("班级查找失败！")
					this.reload();
				})
			},
			addSubmit(){
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/admin/fclass/add',datas)
						.then(res => {
							this.$message.success("添加成功！")
							this.form.resetFields();
							this.reload();  //刷新
						})
						.catch(error =>{
							this.$message.error("添加失败！")
							this.form.resetFields();
							this.reload();  //刷新
						})
					}
				});
			},
			editSubmit(){
				request.post('/api/admin/fclass/update',this.upform)
				.then(res =>{
					this.$message.success("修改成功！")
					this.reload();  //刷新
				})
				.catch(error => {
					this.$message.error("修改失败！")
					this.reload();  //刷新
				})
			},
			delstu(id) {
				console.log(id)
				//const sid = id
				request.delete('/api/admin/fclass/delete/' + id)
					.then(res => {
						this.$message.success("删除成功!!")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("删除失败!!")
						this.reload();  //刷新
					})
			},
		}
	};
</script>
<style scoped>
	.editable-row-operations a {
		margin-right: 8px;
	}

	.input-search {
		width: 300px;
	}
</style>
