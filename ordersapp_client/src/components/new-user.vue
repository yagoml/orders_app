<template>
	<div class="row new-user">
		<div class="container">
			<h3 class="text-center">Cadastro</h3>
			<div class="col-sm-offset-3 col-sm-6 col-xs-12">
				<div>
					<label>Nome Completo</label>
					<input v-model="name" class="form-control" type="text">
				</div>
				<div>
					<label>Celular</label>
					<input v-model="phone" class="form-control" type="text">
				</div>
				<div>
					<label>E-mail</label>
					<input v-model="email" class="form-control" type="text">
				</div>
				<div>
					<button @click="sendData" class="btn btn-primary pull-right">Enviar</button>
				</div>
			</div>
		</div>
	</div>
</template>

<script>

	export default {
		components: {
			
		},
		created() {

		},
		data() {
			return {
				name: '',
				phone: '',
				email: '',
				userData: {}
			}
		},
		methods: {
			sendData() {
				this.userData = {
					nome: this.name,
					celular: this.phone,
					email: this.email
				}

				this.$store.dispatch('save-new-user', this.userData)
			}
		},
		watch: {
			
		},
		computed: {
			
		}
	}
</script>

<style lang='less'>
	.new-user {
		div {
			margin-bottom: 15px;
		}
	}
</style>