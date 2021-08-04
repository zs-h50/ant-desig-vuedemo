<template>
	<div id="">
		<a-form-model :model="form" :label-col="labelCol" :wrapper-col="wrapperCol">
			<a-form-model-item label="Activity name">
				<a-input v-model="form.name" />
			</a-form-model-item>
		</a-form-model>
	</div>
</template>

<script>
	export default {
		inject: ['reload'],
		data() {
			return {
				formLayout: 'horizontal',
				form: this.$form.createForm(this, {
					name: 'coordinated'
				}),
			};
		},
		created() {

		},
		methods: {

			handleSubmit(e) {
				e.preventDefault();
				this.form.validateFields((err, values) => {
					if (!err) {

					}
				});
			},
		},
	};
</script>
