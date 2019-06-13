<template>
	<div class="new-vendor">
		<div class="row">
			<div class="col-sm-6 col-xs-12">
				<label for="basic-url">Razão Social</label>
				<div class="input-group">
					<input
						:model="vendor.name"
						:value="vendor.name"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">CNPJ</label>
				<div class="input-group">
					<input
						:model="vendor.cnpj"
						:value="vendor.cnpj"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">CPF</label>
				<div class="input-group">
					<input
						:model="vendor.cpf"
						:value="vendor.cpf"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">Email</label>
				<div class="input-group">
					<input
						:model="vendor.email"
						:value="vendor.email"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">Telefone</label>
				<div class="input-group">
					<input
						:model="vendor.phone"
						:value="vendor.phone"
						type="text" class="form-control"
						placeholder=""
					>
				</div>
			</div>

			<div class="col-sm-6 col-xs-12">
				<div class="row">
					<div class="col-sm-6 col-xs-12">
						<label for="basic-url">Estado</label>
						<div class="input-group">
							<select
								:model="vendor.estado"
								:value="vendor.estado"
								class="form-control"
							></select>
						</div>
					</div>

					<div class="col-sm-6 col-xs-12">
						<label for="basic-url">Cidade</label>
						<div class="input-group">
							<select
								:model="vendor.city_id"
								:value="vendor.city_id"
								class="form-control"
							></select>
						</div>
					</div>
				</div>

				<label for="basic-url">CEP</label>
				<div class="input-group">
					<input
						:model="vendor.cep"
						:value="vendor.cep"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">Avatar</label>
				<div class="input-group">
					<uploader :params="{ vendorID: vendorID, endPoint: 'vendorAvatar' }"></uploader>
				</div>
			</div>

			<div class="col-xs-12 text-center" style="magin-top: 15px;">
				<button class="btn btn-default">
					<router-link :to="{ path: '/adm/vendors' }">Voltar</router-link>
				</button>
				<button class="btn btn-primary">Salvar</button>
			</div>
		</div>
	</div>
</template>

<script>
	import Uploader from '../../uploader'

	export default {
		components: {
			Uploader
		},
		data() {
			return {
				vendor: {
					
				}
			}
		}
	}
</script>

<style lang='less'>
	.new-vendor {
		.input-group {
			margin-bottom: 15px;
			width: 100%;
		}
	}
</style>