<template>
	<div>
		<a-input-group compact>
			<a-select style="float: right;" @change="onSearch" default-value="0">
				<a-select-option value="0">
					全部学期
				</a-select-option>
				<a-select-option value="1">
					第一学期
				</a-select-option>
				<a-select-option value="2">
					第二学期
				</a-select-option>
			</a-select>
			<a-select :data-source="temp" @change="twoSearch" default-value="0" style="float: right;">
				<a-select-option value="2">
					全部
				</a-select-option>
				<a-select-option value="0">
					开课
				</a-select-option>
				<a-select-option value="1">
					结课
				</a-select-option>
			</a-select>
		</a-input-group>
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1050, y: 385 }" :pagination="paginationOpt"
			row-key="eId">
			<span slot="Fettle" slot-scope="text,record">
				<span v-if="record.eFettle == 0" >开课</span>
				<span v-if="record.eFettle == 1" >结课</span>
			</span>
			<span slot="eSemester" slot-scope="text,record">
				<span v-if="record.eSemester == 1">第一学期</span>
				<span v-if="record.eSemester == 2">第二学期</span>
			</span>
		</a-table>
	</div>

</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'eId',
			key: 'eId',
			fixed: 'left'
		},
		{
			title: '课程编号',
			width: 100,
			align: 'center',
			dataIndex: 'course.cNo',
			key: 'course.cNo',
			fixed: 'left'
		},
		{
			title: '课程名称',
			width: 100,
			align: 'center',
			dataIndex: 'course.cName',
			key: 'course.cName',
		},
		{
			title: '授课老师',
			width: 100,
			align: 'center',
			dataIndex: 'teacher.tName',
			key: 'teacher.tName',
		},
		{
			title: '年份',
			dataIndex: 'eYear',
			key: '1',
			width: 150,
			align: 'center',
		},
		{
			title: '班级名称',
			dataIndex: 'fclass.classname',
			key: '2',
			width: 150,
			align: 'center',
		},
		{
			title: '班级人数',
			dataIndex: 'fclass.cNumber',
			key: '3',
			width: 150,
			align: 'center',
		},
		{
			title: '学期',
			dataIndex: 'eSemester',
			key: '4',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'eSemester'
			}
		},
		{
			title: '状态',
			dataIndex: 'eFettle',
			key: '5',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'Fettle'
			}
		},
		{
			title: '备注',
			dataIndex: 'eRemark',
			key: '6',
			width: 150,
			align: 'center',
		},
	];

	const dataSource = [{
		eId: '1',
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource,
				columns,
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
				},
				dates:'',
				temp:[],
			};
		},
		created() {
			const user = sessionStorage.getItem("user");
			const users = JSON.parse(user);
			this.dates = users.account;
			this.courseload()
		},
		methods: {
			courseload() {
				request.post('/api/student/course/select', this.dates)
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
			onSearch(value) {
				console.log(value)
				if(value == "0"){
					request.post('/api/student/course/select', this.dates)
						.then(res => {
							console.log(res.data)
							this.dataSource = res.data
							//this.reload();  //刷新
						})
						.catch(error => {
							this.$message.error("查询错误！！")
						})
				}else{
					request.get('/api/student/course/select/one',{
						params: {
							e: value,
							account: this.dates
						}
					})
					.then(res => {
						console.log(res.data)
						//this.dataSource.classname = res.data.fclass.classname
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
				}
			},
			twoSearch(value){
				console.log(value)
				if(value == "2"){
					request.post('/api/student/course/select', this.dates)
						.then(res => {
							console.log(res.data)
							this.dataSource = res.data
							//this.reload();  //刷新
						})
						.catch(error => {
							this.$message.error("查询错误！！")
						})
				}else{
					request.get('/api/student/course/select/two',{
						params: {
							e: value ,
							account: this.dates
						}
					})
					.then(res => {
						console.log(res.data)
						//this.dataSource.classname = res.data.fclass.classname
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
				}
			},
		},
	};
</script>
<style scoped>
	.ainput {
		float: right;
	}
</style>
