<template>
	<div>
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">
			授课
			<a-modal title="分配" :visible="visible" :footer="null" @cancel="handleCancel">
				<!-- 放个表单 -->
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
					<a-form-item label="班级">
						<a-select v-decorator="['cId', { rules: [{ required: true, message: '班级不能为空'}]}]"
							placeholder="请选择">
							<a-select-option v-for="(item,index) in fclass" :value="item.cId">
								{{item.classname}}
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="课程">
						<a-select v-decorator="['courseId',{ rules: [{ required: true, message: '课程不能为空' }] },
					]" placeholder="请选择">
							<a-select-option v-for="(item,index) in loads" :value="item.cId" v-if="item.cFettle == 0">
								{{item.cName}}
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="老师">
						<a-select v-decorator="['tId', { rules: [{ required: true, message: '老师不能为空'}]}]"
							placeholder="请选择">
							<a-select-option v-for="(item,index) in datas" :value="item.tId" v-if="item.tFettle == 0">
								{{item.tName}}
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="年份">
						<a-input v-decorator="['eYear', { rules: [{ required: true, message: '年份不能为空'}]}]"
							placeholder="请输入年份" />
					</a-form-item>
					<a-form-item label="学期">
						<a-select v-decorator="[
						  'eSemester',
						  { rules: [{ required: true, message: '学期不能为空' }] },
						]" placeholder="请选择">
							<a-select-option value="1">
								第一学期
							</a-select-option>
							<a-select-option value="2">
								第二学期
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="状态">
						<a-select v-decorator="[
					  'eFettle',
					  { rules: [{ required: true, message: '状态不能为空' }] },
					]" placeholder="请选择">
							<a-select-option value="0">
								开课
							</a-select-option>
							<a-select-option value="1">
								结课
							</a-select-option>
						</a-select>
					</a-form-item>
					<a-form-item label="备注">
						<a-input v-decorator="['eRemark', { rules: [{ required: false}]}]" placeholder="请输入备注" />
					</a-form-item>
					<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
						<a-button type="primary" html-type="submit">
							提交
						</a-button>
					</a-form-item>
				</a-form>
			</a-modal>
		</a-button>

		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 1600, y: 385 }" :pagination="paginationOpt"
			row-key="eId">
			<div slot="filterDropdown" slot-scope="{ setSelectedKeys, selectedKeys, confirm, clearFilters, column }"
				style="padding: 8px">
				<a-input v-ant-ref="c => (searchInput = c)" :placeholder="`输入${column.title}`" :value="selectedKeys[0]"
					style="width: 188px; margin-bottom: 8px; display: block;"
					@change="e => setSelectedKeys(e.target.value ? [e.target.value] : [])"
					@pressEnter="() => handleSearch(selectedKeys, confirm, column.dataIndex)" />
				<a-button type="primary" icon="search" size="small" style="width: 90px; margin-right: 8px"
					@click="() => handleSearch(selectedKeys, confirm, column.dataIndex)">
					搜索
				</a-button>
				<a-button size="small" style="width: 90px" @click="() => handleReset(clearFilters)">
					清空
				</a-button>
				<!-- 图标 -->
			</div>
			<a-icon slot="filterIcon" slot-scope="filtered" type="search"
				:style="{ color: filtered ? '#108ee9' : undefined }" />

			<template slot="customRender" slot-scope="text, record, index, column">
				<span v-if="searchText && searchedColumn === column.dataIndex">
					<template v-for="(fragment, i) in text
			            .toString()
			            .split(new RegExp(`(?<=${searchText})|(?=${searchText})`, 'i'))">
						<mark v-if="fragment.toLowerCase() === searchText.toLowerCase()" :key="i"
							class="highlight">{{ fragment }}</mark>
						<template v-else>{{ fragment }}</template>
					</template>
				</span>
				<template v-else>
					{{ text }}
				</template>
			</template>

			<!-- 序号 -->
			<span slot="num" slot-scope="text,record,index">
				{{(paginationOpt.defaultCurrent-1)*paginationOpt.defaultPageSize+parseInt(index)+1}}
			</span>

			<!-- 鼠标停留显示出文字 -->
			<div :title="text" slot="customRender" slot-scope="text, record">
				<div :style="{textAlign:'left'}">{{text}}</div>
			</div>

			<span slot="Fettle" slot-scope="text,record">
				<a-tag color="green" v-if="record.eFettle == 0" style="font-size: 13px;">开课</a-tag>
				<a-tag color="red" v-if="record.eFettle == 1" style="font-size: 13px;">结课</a-tag>
			</span>
			<span slot="eSemester" slot-scope="text,record">
				<a-tag color="#2db7f5" v-if="record.eSemester == 1" style="font-size: 13px;">
					第一学期
				</a-tag>
				<a-tag color="#108ee9" v-if="record.eSemester == 2" style="font-size: 13px;">
					第二学期
				</a-tag>
			</span>


			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
					<!-- 放个表单 -->
					<a-form-model :model="upform" ref="ruleForm" :rules="rules" :label-col="{ span: 7 }"
						:wrapper-col="{ span: 12 }">
						<a-form-model-item ref="cId" prop="cId" label="班级">
							<a-select v-model="upform.cId" placeholder="请选择">
								<a-select-option v-for="(item,index) in fclass" :value="item.cId">
									{{item.classname}}
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="courseId" prop="courseId" label="课程名称">
							<a-select v-model="upform.courseId" placeholder="请选择">
								<a-select-option v-for="(item,index) in loads" :value="item.cId">
									{{item.cName}}
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="tId" prop="tId" label="老师标识">
							<a-select v-model="upform.tId" placeholder="请选择">
								<a-select-option v-for="(item,index) in datas" :value="item.tId">
									{{item.tName}}
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="eYear" prop="eYear" label="年份">
							<a-input v-model="upform.eYear" placeholder="请输入年份" />
						</a-form-model-item>
						<a-form-model-item ref="eSemester" prop="eSemester" label="学期">
							<a-select v-model="upform.eSemester" placeholder="请选择">
								<a-select-option value="1">
									第一学期
								</a-select-option>
								<a-select-option value="2">
									第二学期
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="eFettle" prop="eFettle" label="状态">
							<a-select v-model="upform.eFettle" placeholder="请选择">
								<a-select-option value="0">
									开课
								</a-select-option>
								<a-select-option value="1">
									结课
								</a-select-option>
							</a-select>
						</a-form-model-item>
						<a-form-model-item ref="eRemark" prop="eRemark" label="备注">
							<a-input v-model="upform.eRemark" placeholder="请输入备注" />
						</a-form-model-item>
						<a-form-model-item :wrapper-col="{ span: 12, offset: 10 }">
							<a-button type="primary" @click="editSubmit">
								提交
							</a-button>
						</a-form-model-item>
					</a-form-model>
				</a-modal>
			</a-button>
			<a-button slot="action3" slot-scope="text,record" size="small" type="danger" icon="delete"
				@click="delstu(record.eId)">删除</a-button>
		</a-table>
	</div>

</template>
<script>
	import request from '@/utils/request.js'
	const columns = [{
			title: '序号',
			width: 50,
			align: 'center',
			scopedSlots: {
				customRender: 'num'
			}
		},
		{
			title: 'ID',
			width: 100,
			align: 'center',
			dataIndex: 'eId',
			key: 'eId',
		},
		{
			title: '课程编号',
			width: 100,
			align: 'center',
			dataIndex: 'course.cNo',
			key: 'course.cNo',

		},
		{
			title: '课程名称',
			width: 100,
			align: 'center',
			dataIndex: 'course.cName',
			key: 'course.cName',
			scopedSlots: {
				filterDropdown: 'filterDropdown',
				filterIcon: 'filterIcon',
				customRender: 'customRender',
			},
			onFilter: (value, record) =>
				record.course.cName
				.toString()
				.toLowerCase()
				.includes(value.toLowerCase()),
			onFilterDropdownVisibleChange: visible => {
				if (visible) {
					setTimeout(() => {
						this.searchInput.focus();
					});
				}
			},

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
			defaultSortOrder: 'descend',
			sorter: (a, b) => a.eYear - b.eYear,
		},
		{
			title: '学期',
			dataIndex: 'eSemester',
			key: '4',
			width: 150,
			align: 'center',
			scopedSlots: {
				customRender: 'eSemester'
			},
			filters: [{
					text: '第一学期',
					value: '第一学期',
				},
				{
					text: '第二学期',
					value: '第二学期',
				},
			],
			filterMultiple: false,
			onFilter: (value, record) => record.eSemester.value === value,
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
			width: 60,
			customRender: (value, row, index) => { //表体的数据列样式
				console.log(value, row, index) //本列的值,所有行数据包括本列,第几列
				const obj = {
					children: value,
					attrs: {},
				};
				obj.attrs.align = 'left';
				return obj;
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
		{
			title: '操作',
			key: 'operation2',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作',
			key: 'operation3',
			width: 100,
			align: 'center',
			scopedSlots: {
				customRender: 'action3'
			},
		},
	];

	const dataSource = [{
		eId: '1',
	}, ];

	export default {
		inject: ['reload'],
		data() {
			return {
				searchText: '',
				searchInput: null,
				searchedColumn: '',
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
					onShowSizeChange: (current, pageSize) => {
						this.paginationOpt.defaultCurrent = 1;
						this.paginationOpt.defaultPageSize = pageSize;
					},
					// 改变每页数量时更新显示
					//onChange页码改变的回调，参数是改变后的页码及每页条数
					onChange: (current, size) => {
						this.paginationOpt.defaultCurrent = current;
						this.paginationOpt.defaultPageSize = size;
					},
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
				rules: {
					cId: [{
						required: true,
						message: '请输入修改的课程',
						trigger: 'blur'
					}, ],
					tId: [{
						required: true,
						message: '请输入修改的老师',
						trigger: 'blur'
					}, ],
					eYear: [{
						required: true,
						message: '请输入修改的年份',
						trigger: 'blur'
					}, ],
					eSemester: [{
						required: true,
						message: '请输入修改的学期',
						trigger: 'blur'
					}, ],
					eFettle: [{
						required: true,
						message: '请输入修改的状态',
						trigger: 'blur'
					}, ],
					eRemark: [{
						required: false,
						message: '请输入修改的备注',
						trigger: 'blur'
					}, ],
					courseId: [{
						required: true,
						message: '请输入修改的姓名',
						trigger: 'blur'
					}, ],
				},
				fclass: [],
				loads: [],
				datas: [],

			};
		},
		created() {
			this.fclassload()
			this.courseload()
			this.load()
			this.teacherload()
		},
		methods: {
			teacherload() {
				request.post('/api/admin/teacher/select')
					.then(res => {
						this.datas = res.data
						//this.reload();  //刷新
					})
					.catch(error => {
						this.$message.error("查询错误！！")
					})
			},
			load() {
				request.post('/api/admin/addcourse/select')
					.then(res => {
						//console.log(res.data)
						this.loads = res.data
					})
					.catch(error => {
						console.log(error)
					})
			},
			fclassload() {
				request.post("/api/admin/fclass/select")
					.then(res => {
						this.fclass = res.data
					})
					.catch(error => {
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
			addSubmit() {
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/admin/course/add', datas)
							.then(res => {
								if (res.code == "100") {
									this.$message.error(res.msg)
								} else {
									this.$message.success("添加成功！")
									this.reload(); //刷新
								}
							})
							.catch(error => {
								this.$message.error("添加失败！")
								this.reload(); //刷新
							})
					}
				});
			},
			editSubmit() {
				request.post('/api/admin/course/update', this.upform)
					.then(res => {
						this.$message.success("修改成功！")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("修改失败！")
						this.reload(); //刷新
					})
			},
			// 删除
			delstu(id) {
				console.log(id)
				//const sid = id
				request.delete('/api/admin/course/delete/' + id)
					.then(res => {
						this.$message.success("删除成功!!")
						this.reload(); //刷新
					})
					.catch(error => {
						this.$message.error("删除失败!!")
						this.reload(); //刷新
					})
			},
			handleSearch(selectedKeys, confirm, dataIndex) {
				confirm();
				this.searchText = selectedKeys[0];
				this.searchedColumn = dataIndex;
			},

			handleReset(clearFilters) {
				clearFilters();
				this.searchText = '';
			},
		},
		computed: {

		},
		components: {

		}
	};
</script>
<style scoped>
	/deep/.ant-table-thead>tr>th {
		white-space: nowrap;
		text-align: center;
	}

	/deep/.ant-table-row td {
		white-space: nowrap;
	}
</style>
