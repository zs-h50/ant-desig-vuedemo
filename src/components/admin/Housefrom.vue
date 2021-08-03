<template>
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
</template>

<script>
	import request from '@/utils/request.js'
	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this),
			};
		},
		methods:{
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
			},
		}
	}
</script>

<style>
</style>
