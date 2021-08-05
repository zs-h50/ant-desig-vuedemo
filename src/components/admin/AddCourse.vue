<template>
	<div>
		<a-button size="large" @click="showModal()" type="primary" icon="plus-square">新增课程
			<a-modal title="新增" :visible="visible" :footer="null" @cancel="handleCancel">
				<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="addSubmit">
					<a-form-item label="班级标识">
						<a-input disabled v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
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
		<a-input-search placeholder="请输入要搜索的班级名称" enter-button="搜索" size="large" class="input-search"
			@search="onSearch" />
		<a-table :columns="columns" :data-source="dataSource" :scroll="{ x: 600,y:385}" row-key="cId">
	
			<a-button slot="action2" slot-scope="text,record" size="small" icon="form" @click="enditModal(record)">编辑
				<a-modal title="修改" :visible="visibles" :footer="null" @cancel="handleCancels">
					<a-form-model :form="upform" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }"
						@submit="editSubmit">
						<a-form-item label="班级标识">
							<a-input disabled v-model:value="upform.cId"
								v-decorator="['cId', { rules: [{ required: true, message: '班级标识不能为空'}]}]"
								placeholder="请输入班级标识" />
						</a-form-item>
						<a-form-item label="班级名称">
							<a-input v-model:value="upform.classname"
								v-decorator="['classname', { rules: [{ required: true, message: '班级名称不能为空'}]}]"
								placeholder="请输入班级名称" />
						</a-form-item>
						<a-form-item label="班级人数">
							<a-input v-model:value="upform.cNumber"
								v-decorator="['cNumber', { rules: [{ required: true, message: '班级人数不能为空'}]}]"
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
			title: '操作',
			key: 'operation2',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action2'
			},
		},
		{
			title: '操作',
			key: 'operation3',
			fixed: 'right',
			width: 100,
			scopedSlots: {
				customRender: 'action3'
			},
		},
	];
	const dataSource = [{
		cId: 1
	}]
	
</script>

<style>
</style>
