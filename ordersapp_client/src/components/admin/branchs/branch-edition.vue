<template>
	<div class="branch-edition">
		<div class="row page-header">
			<div class="col-sm-6 col-xs-12">
				<strong>{{ vendorBranch.name }}</strong>
				<br>
				{{ vendorBranch.vendor_branch_id }}
			</div>

			<div class="col-sm-6 col-xs-12">
				<button class="btn btn-default" @click="goToStores">Produtos</button>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6 col-sm-9 col-xs-12">
				<label for="basic-url">Razão Social</label>
				<div class="input-group">
					<input
						:model="vendorBranch.name"
						:value="vendorBranch.name"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">CNPJ</label>
				<div class="input-group">
					<input
						:model="vendorBranch.cnpj"
						:value="vendorBranch.cnpj"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">Endereço</label>
				<div class="input-group">
					<input
						:model="vendorBranch.address"
						:value="vendorBranch.address"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<div class="row">
					<div class="col-sm-6 col-xs-12">
						<label for="basic-url">Estado</label>
						<div class="input-group">
							<select
								:model="vendorBranch.estado"
								:value="vendorBranch.estado"
								class="form-control"
							></select>
						</div>
					</div>

					<div class="col-sm-6 col-xs-12">
						<label for="basic-url">Cidade</label>
						<div class="input-group">
							<select
								:model="vendorBranch.city_id"
								:value="vendorBranch.city_id"
								class="form-control"
							></select>
						</div>
					</div>
				</div>

				<label for="basic-url">CEP</label>
				<div class="input-group">
					<input
						:model="vendorBranch.cep"
						:value="vendorBranch.cep"
						type="text" class="form-control"
						placeholder=""
					>
				</div>

				<label for="basic-url">Coordenadas</label>
				<div class="input-group">
					<input
						:model="vendorBranch.coordinates"
						:value="vendorBranch.coordinates"
						type="text" class="form-control"
						placeholder=""
					>
				</div>
			</div> 
			
			<div class="col-sm-6 col-xs-12">
				<label for="basic-url">Avatar</label>
				<div class="input-group">
					<uploader :params="{ branchID: branchID, endPoint: 'vendorBranchAvatar' }"></uploader>
				</div>

				<label for="basic-url">Banner</label>
				<div class="input-group">
					<uploader :params="{ branchID: branchID, endPoint: 'vendorBranchBanner' }"></uploader>
				</div>

				<label for="basic-url">Valor mínimo</label>
				<div class="input-group">
					<span class="input-group-addon">$</span>
					<input
						:model="vendorBranch.minimum_value"
						:value="vendorBranch.minimum_value"
						type="number" class="form-control"
						placeholder="para entregas"
					>
				</div>

				<div class="col-xs-6">
					<div class="row">
						<label for="basic-url">Tempo médio mínimo</label>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input
								:model="vendorBranch.delivery_time_min"
								:value="vendorBranch.delivery_time_min"
								type="number" class="form-control"
								placeholder="para entregas"
							>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="row">
						<label for="basic-url">Tempo médio máximo</label>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input
								:model="vendorBranch.delivery_time_max"
								:value="vendorBranch.delivery_time_max"
								type="number" class="form-control"
								placeholder="para entregas"
							>
						</div>
					</div>
				</div>

				<div class="col-xs-6">
					<div class="row">
						<label for="basic-url">Horário de abertura</label>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input
								:model="vendorBranch.open"
								:value="vendorBranch.open"
								type="time" class="form-control"
								placeholder="para entregas"
							>
						</div>
					</div>
				</div>

				<div class="col-xs-6">
					<div class="row">
						<label for="basic-url">Horário de fechamento</label>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input
								:model="vendorBranch.close"
								:value="vendorBranch.close"
								type="time" class="form-control"
								placeholder="para entregas"
							>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 text-center" style="magin-top: 15px;">
				<button class="btn btn-danger">Desativar</button>
				<router-link class="btn btn-default"
					:to="{ path: `/adm/branchs/${ vendorID }` }"
				>Voltar</router-link>
				<button class="btn btn-primary">Salvar</button>
			</div>
		</div>
	</div>
</template>

<script>
	import _ from 'lodash'
	import Uploader from '../../uploader'

	export default {
		props: ['branchID', 'vendorID'],
		components: {
			Uploader
		},
		created() {
			this.loadVendorBranchs()
		},
		data() {
			return {
				vendorBranch: {}
			}
		},
		methods: {
			goToStores() {
				this.$router.push({
					path: `/adm/products/${ this.branchID }`
				})
			},
			getStoreVendorBranch() {
				return _.find(this.vendorBranchs, {
					vendor_branch_id: this.branchID
				})
			},
			loadVendorBranchs() {
				this.loading = true

				this.$store.dispatch('load-vendor-branchs', {
					vendorID: this.vendorID
				})
			}
		},
		watch:{
			vendorBranchs(newValue, oldValue) {
				this.vendorBranch = this.getStoreVendorBranch()

				if(!_.isEmpty(this.vendorBranch))
					this.$emit('branchTargetChanged', this.vendorBranch)
			}
		},
		computed: {
			vendorBranchs() {
				this.loading = false
				return this.$store.getters.vendorBranchs
			}
		}
	}
</script>

<style lang='less'>

</style>