<template>
	<div>
		<a-input-search placeholder="请输入要搜索课程" enter-button="搜索" size="large" class="input-search" @search="onSearch" />
		<a-table :columns="columns" :data-source="dataSource" :pagination="paginationOpt" :scroll="{ x: 800 }" row-key="eId">
			<span slot="num" slot-scope="text,record,index">
				{{(paginationOpt.defaultCurrent-1)*paginationOpt.defaultPageSize+parseInt(index)+1}}
			</span>
			<span slot="eSemester" slot-scope="text,record">
				<span v-if="record.eSemester == 1">第一学期</span>
				<span v-if="record.eSemester == 2">第二学期</span>
			</span>
			<a-button slot="action" slot-scope="text,record" size="small" type="dashed" icon="search"
				@click="selectstudentExam(record)">查看
				<a-modal title="学生成绩" :visible="Onselect" @cancel="selectCancels" :footer='null'>
					<div v-infinite-scroll="handleInfiniteOnLoad" class="demo-infinite-container"
						:infinite-scroll-disabled="busy" :infinite-scroll-distance="10">
						<a-list :data-source="data">
							<a-list-item slot="renderItem" slot-scope="item, index">
								<a-list-item-meta :description="item.student.sNo">
									<a slot="title" :href="item.href">{{ item.student.sName }}</a>
								</a-list-item-meta>
								<div>成绩：{{item.aScore}}</div>
							</a-list-item>
							<div v-if="loading && !busy" class="demo-loading-container">
								<a-spin />
							</div>
						</a-list>
					</div>
				</a-modal>
			</a-button>
		</a-table>
	</div>
</template>
<script>
	import request from '@/utils/request.js'
	import infiniteScroll from 'vue-infinite-scroll';
	const columns = [{
			title: '序号',
			width: 100,
			align: 'center',
			fixed: 'left',
			scopedSlots: {
				customRender: 'num'
			},
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
			dataIndex: 'eYear',
			key: '4'
		},
		{
			title: '学期',
			align: 'center',
			width: 100,
			dataIndex: 'eSemester',
			key: '5',
			scopedSlots: {
				customRender: 'eSemester'
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
			title: '操作',
			align: 'center',
			width: 100,
			dataIndex: 'action',
			key: '8',
			scopedSlots: {
				customRender: 'action'
			},
		},
	];

	const data = [{
		aId: 1,
	}, ];

	export default {
		inject: ['reload'],
		directives: {
			infiniteScroll
		},
		data() {
			return {
				data,
				columns,
				loading: false,
				busy: false,
				Onselect: false,
				dataSource:[],
				paginationOpt: {
					defaultCurrent: 1, // 默认当前页数
					defaultPageSize: 8, // 默认当前页显示数据的大小
					total: 0, // 总数，必须先有
					showQuickJumper: true,
					showTotal: (total) => `共 ${total} 条`, // 显示总数
					onShowSizeChange: (current, pageSize) => {
						this.paginationOpt.defaultCurrent = 1;
						this.paginationOpt.defaultPageSize = pageSize;
						//this.searchCameraFrom(); //显示列表的接口名称
					},
					// 改变每页数量时更新显示
					//onChange页码改变的回调，参数是改变后的页码及每页条数
					onChange: (current, size) => {
						this.paginationOpt.defaultCurrent = current;
						this.paginationOpt.defaultPageSize = size;
						//this.searchCameraFrom();
					},
				},
			};
		},
		created() {
			this.courseload()
		},
		methods: {
			selectCancels(){
				this.Onselect = false
			},
			selectstudentExam(record){
				const cNo =  record.course.cNo;
				const classname = record.fclass.classname;
				request.get("/api/admin/student/fclass/exam/select",{
					params:{
						cNo:cNo,
						classname:classname
					}
				})
				.then(res =>{
					this.data=res.data
				})
				this.Onselect = true
			},
			handleInfiniteOnLoad() {
				const data = this.data;
				this.loading = true;
				if (data.length > 60) {
					this.$message.warning('Infinite List loaded all');
					this.busy = true;
					this.loading = false;
					return;
				}
			},
			courseload() {
				request.post('/api/admin/course/select')
					.then(res => {
						this.dataSource = res.data
						//this.reload();  //刷新
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			onSearch(value) {
				console.log(value)
				const result = value;
				request.post('/api/admin/exam/select/search', result)
					.then(res => {
						this.dataSource = res.data
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
	.demo-infinite-container {
		border: 1px solid #e8e8e8;
		border-radius: 4px;
		overflow: auto;
		padding: 8px 24px;
		height: 300px;
	}
	
	.demo-loading-container {
		position: absolute;
		bottom: 40px;
		width: 100%;
		text-align: center;
	}
</style>
