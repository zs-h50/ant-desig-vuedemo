<template>
	<a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmit">
		<a-form-item label="姓名" width="50%">
			<a-input v-decorator="['sName', { rules: [{ required: true, message: '学生姓名不能为空'}]}]"
				placeholder="请输入学生的姓名" />
		</a-form-item>
		<a-form-item label="学号">
			<a-input disabled v-decorator="['sNo', { rules: [{ required: false, message: '学生学号不能为空' }] }]"
				placeholder="请输入学生的学号" />
		</a-form-item>
		<a-form-item label="性别">
			<a-select v-decorator="[
          'gender',
          { rules: [{ required: true, message: '性别不能为空' }] },
        ]" placeholder="选择学生的性别">
				<a-select-option value="1">
					男
				</a-select-option>
				<a-select-option value="0">
					女
				</a-select-option>
			</a-select>
		</a-form-item>
		<a-form-item label="联系方式">
			<a-input
				v-decorator="['sPhone', { rules: [{ required: true, message: '学生联系方式不能为空' },{min:11,len:11,message: '请输入正确的格式'}] }]"
				placeholder="请输入学生的联系方式" />
		</a-form-item>
		<a-form-item label="邮箱">
			<a-input
				v-decorator="['email', { rules: [{ required: true, message: '学生邮箱不能为空' },{type:'email',message: '请输入正确的格式'}] }]"
				placeholder="请输入学生的邮箱方式" />
		</a-form-item>
		<!-- 出生日期 -->
		<a-form-item label="出生日期" style="margin-bottom:0;">
			<a-date-picker v-decorator="['birthday', { rules: [{ required: true, message: '学生出生日期不能为空' }] }]"
				style="width: 100%" />
		</a-form-item>
		<a-form-item label="身份证号">
			<a-input
				v-decorator="['idCard', { rules: [{ required: true, message: '学生身份证号不能为空' },{min:18,len:18,message: '请输入正确的格式'}] }]"
				placeholder="请输入学生的身份证号" />
		</a-form-item>
		<a-form-item label="联系人">
			<a-input v-decorator="['contact', { rules: [{ required: true, message: '学生联系人不能为空' }] }]"
				placeholder="请输入学生的联系人" />
		</a-form-item>
		<a-form-item label="联系人方式">
			<a-input v-decorator="['contactphone', { rules: [{ required: true, message: '学生联系人方式不能为空' }] }]"
				placeholder="请输入学生的联系人方式" />
		</a-form-item>
		<a-form-item label="住址">
			<a-input v-decorator="['address', { rules: [{ required: true, message: '学生住址不能为空' }] }]"
				placeholder="请输入学生的住址" />
		</a-form-item>
		<a-form-item label="邮编">
			<a-input
				v-decorator="['postcode', { rules: [{ required: true, message: '学生邮编不能为空' },{min:6,len:6,message: '请输入正确的格式'}] }]"
				placeholder="请输入学生的邮编" />
		</a-form-item>
		<a-form-item label="家庭状况">
			<a-input v-decorator="['situation', { rules: [{ required: false}] }]" placeholder="请输入学生的家庭状况" />
		</a-form-item>
		<a-form-item label="父亲姓名">
			<a-input disabled v-decorator="['father', { rules: [{ required: false, message: '学生父亲姓名不能为空' }] }]"
				placeholder="请输入学生的父亲姓名" />
		</a-form-item>
		<a-form-item label="父亲电话">
			<a-input disabled v-decorator="['fatherphone', { rules: [{ required: false, message: '学生父亲电话不能为空' }] }]"
				placeholder="请输入学生的父亲电话" />
		</a-form-item>
		<a-form-item label="母亲姓名">
			<a-input disabled v-decorator="['mather', { rules: [{ required: false, message: '学生母亲姓名不能为空' }] }]"
				placeholder="请输入学生的母亲姓名" />
		</a-form-item>
		<a-form-item label="母亲电话">
			<a-input disabled v-decorator="['matherphone', { rules: [{ required: false, message: '学生母亲电话不能为空' }] }]"
				placeholder="请输入学生的母亲电话" />
		</a-form-item>
		<a-form-item label="就学状态">
			<a-select v-decorator="[
		  'fettle',
		  { rules: [{ required: true, message: '就学状态不能为空' }] },
		]" placeholder="选择类型">
				<a-select-option value="1">
					在读
				</a-select-option>
				<a-select-option value="2">
					休学
				</a-select-option>
				<a-select-option value="3">
					退学
				</a-select-option>
			</a-select>
		</a-form-item>
		<a-form-item label="备注">
			<a-input v-decorator="['remark', { rules: [{ required: false}] }]" placeholder="备注" />
		</a-form-item>
		<a-form-item label="班级">
			<a-select v-decorator="[
			  'cId',{ rules: [{ required: true, message: '学生班级不能为空' }] }]" placeholder="班级">
				<a-select-option v-for="(item,index) in dataSource" :value="item.cId">
					{{item.classname}}
				</a-select-option>
			</a-select>
		</a-form-item>
		<a-form-item :wrapper-col="{ span: 12, offset: 5 }">
			<a-upload name="avatar" list-type="picture-card" class="avatar-uploader" :show-upload-list="false"
				action="http://localhost:9091/" :before-upload="beforeUpload"
				@change="handleChange">
				<img v-if="imageUrl" :src="imageUrl" alt="avatar" />
				<div v-else>
					<a-icon :type="loading ? 'loading' : 'plus'" />
					<div class="ant-upload-text">
						点击上传
					</div>
				</div>
			</a-upload>
		</a-form-item>
		<a-form-item :wrapper-col="{ span: 12, offset: 20 }">
			<a-button type="primary" html-type="submit">
				提交
			</a-button>
		</a-form-item>

	</a-form>
</template>

<script>
	import request from '@/utils/request.js'

	// 头像上传
	function getBase64(img, callback) {
		const reader = new FileReader();
		reader.addEventListener('load', () => callback(reader.result));
		reader.readAsDataURL(img);
	}

	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
				dataSource: [],
				loading: false,
				imageUrl: '',
			};
		},
		created() {
			this.Fclassload()
		},
		methods: {
			Fclassload() {
				request.post("/api/admin/fclass/select")
					.then(res => {
						this.dataSource = res.data
					})
					.catch(error => {
						this.$message.error("查询失败！")
						//this.reload();
					})
			},
			handleSubmit(e) {
				e.preventDefault();
				this.form.validateFields((err, values) => {
					if (!err) {
						const datas = JSON.parse(JSON.stringify(values))
						//console.log(values);
						request.post('/api/admin/studentinfo/add', datas)
							.then(res => {
								if (res.code == "-1") {
									this.$message.error("学生已存在，请重填写！")
								} else if (res.code == "0") {
									this.$message.success("学生添加成功！")
									this.form.resetFields();
									this.reload(); //刷新
								}
							})
					}
				});
			},
			
			// 头像上传
			    handleChange(info) {
			      if (info.file.status === 'uploading') {
			        this.loading = true;
			        return;
			      }
			      if (info.file.status === 'done') {
			        // 获取此 url。
			        getBase64(info.file.originFileObj, imageUrl => {
			          this.imageUrl = imageUrl;
			          this.loading = false;
			        });
			      }
			    },
			    beforeUpload(file) {
			      const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
			      if (!isJpgOrPng) {
			        this.$message.error('只能上传JPG文件！');
			      }
			      const isLt2M = file.size / 1024 / 1024 < 2;
			      if (!isLt2M) {
			        this.$message.error('图片必须小于2MB！');
			      }
			      return isJpgOrPng && isLt2M;
			    },
		},
	};
</script>
<style scoped>
	.ant-form {
		width: 100%;
		display: flex;
		flex-flow: row wrap;
	}

	.ant-form-item {
		width: 50%;
	}

	.avatar-uploader>.ant-upload {
		width: 128px;
		height: 128px;
	}

	.ant-upload-select-picture-card i {
		font-size: 20px;
		color: #999;
	}

	.ant-upload-select-picture-card .ant-upload-text {
		margin-top: 8px;
		color: #666;
	}
</style>
