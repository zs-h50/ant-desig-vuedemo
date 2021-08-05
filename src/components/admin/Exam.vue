<template>
	<div>
		<a-input-search placeholder="请输入要搜索课程" enter-button="搜索" size="large" class="input-search" @search="onSearch" />
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
	const columns = [{
			title: '标识',
			width: 100,
			align: 'center',
			dataIndex: 'aId',
			key: 'aId',
			fixed: 'left'
		},
		{
			title: '课程编号',
			align: 'center',
			width: 100,
			dataIndex: 'course.cNo',
			key: '1'
		},
		{
			title: '课程名称',
			align: 'center',
			width: 100,
			dataIndex: 'course.cName',
			key: '2'
		},
		{
			title: '授课老师',
			align: 'center',
			width: 100,
			dataIndex: 'teacher.tName',
			key: '3'
		},
		{
			title: '年份',
			align: 'center',
			width: 100,
			dataIndex: 'aYears',
			key: '4'
		},
		{
			title: '学期',
			align: 'center',
			width: 100,
			dataIndex: 'aSemester',
			key: '5',
			scopedSlots: {
				customRender: 'aSemester'
			},
		},
		{
			title: '班级名称',
			align: 'center',
			width: 100,
			dataIndex: 'fclass.classname',
			key: '6'
		},
		{
			title: '备注',
			align: 'center',
			width: 100,
			dataIndex: 'aRemark',
			key: '7'
		},
		{
			title: '成绩',
			key: '8',
			dataIndex: 'aScore',
			fixed: 'right',
			width: 100,
			align: 'center',
		},
	];

	const data = [{
		aId: 1,
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				data,
				columns,
			};
		},
		created() {
			this.examload()
		},
		methods: {
			examload() {
				request.post("/api/admin/exam/select")
					.then(res => {
						this.data = res.data
					})
					.catch(error => {
						this.$message.error("查询失败！")
						//this.reload();
					})
			},
			onSearch(value) {
				console.log(value)
				const result = value;
				request.post('/api/admin/exam/select/search', result)
					.then(res => {
						this.data = res.data
					})
					.catch(error => {
						this.$message.error("搜索失败！")
						this.reload();
					})
			},
		}
	};
</script>
<style scoped>
	.input-search {
		width: 300px;
	}
</style>
