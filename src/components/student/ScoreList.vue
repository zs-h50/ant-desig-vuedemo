<template>
	<div>
		<a-input-search placeholder="请输入要搜索课程" enter-button="搜索" size="large" class="input-search" @search="onSearch"/>
			<a-select style="float: right; " @change="Search" default-value="0">
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
		<a-table :columns="columns" :data-source="data" :scroll="{ x: 800 }" row-key="aId">
			<span slot="aSemester" slot-scope="text,record">
				<span v-if="record.aSemester == 1">第一学期</span>
				<span v-if="record.aSemester == 2">第二学期</span>
			</span>
		</a-table>
	</div>
</template>
<script>
	import request from '@/utils/request.js'
	const columns = [
		{
			title: '课程编号',
			align:'center',
			width: 100,
			dataIndex: 'course.cNo',
			key: '1'
		},
		{
			title: '课程名称',
			align:'center',
			width: 100,
			dataIndex: 'course.cName',
			key: '2'
		},

		{
			title: '年份',
			align:'center',
			width: 100,
			dataIndex: 'aYears',
			key: '3'
		},
		{
			title: '学期',
			align:'center',
			width: 100,
			dataIndex: 'aSemester',
			key: '4',
			scopedSlots: {
				customRender: 'aSemester'
			},
		},
		{
			title: '班级名称',
			align:'center',
			width: 100,
			dataIndex: 'fclass.classname',
			key: '5'
		},
		{
			title: '授课老师',
			align:'center',
			width: 100,
			dataIndex: 'teacher.tName',
			key: '6'
		},
		{
			title: '备注',
			align:'center',
			width: 100,
			dataIndex: 'aRemark',
			key: '7'
		},
		{
			title: '成绩',
			key: '8',
			dataIndex:'aScore',
			fixed: 'right',
			width: 100,
			align:'center',
		},
	];

	const data = [{
			aId:1,
		},
	];

	export default {
		inject: ['reload'],
		data() {
			return {
				data,
				columns,
				dates:''
			};
		},
		created() {
			const user = sessionStorage.getItem("user");
			const users = JSON.parse(user);
			this.dates = users.account;
			this.studentexamload()
		},
		methods:{
			studentexamload(){
				request.post("/api/student/exam/select",this.dates)
				.then(res =>{
					this.data = res.data
				})
				.catch(error =>{
					this.$message.error("查询失败！")
					//this.reload();
				})
			},
			onSearch(value){
				console.log(value)
				const result = value;
				request.get('/api/student/exam/select/search',{
						params:{
							account: this.dates,
							result:result
						}
				})
				.then(res => {
					this.data = res.data
				})
				.catch(error=>{
					this.$message.error("搜索失败！")
					this.reload();
				})
			},
			Search(value){
				console.log(value)
				if(value == "0"){
					request.post('/api/student/exam/select', this.dates)
						.then(res => {
							console.log(res.data)
							//this.dataSource.classname = res.data.fclass.classname
							this.data = res.data
							//this.reload();  //刷新
						})
						.catch(error => {
							this.$message.error("查询错误！！")
						})
				}else{
					request.get('/api/student/exam/select/one',{
						params: {
							e: value ,
							account: this.dates
						}
					})
					.then(res => {
						console.log(res.data)
						//this.dataSource.classname = res.data.fclass.classname
						this.data = res.data
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
				}
			}
		}
	};
</script>
<style scoped>
	.input-search{
		width: 300px;
	}
</style>