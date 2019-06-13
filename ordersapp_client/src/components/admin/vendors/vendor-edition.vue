<template>
	<div class="vendor-edition">
		<div class="row page-header">
			<div class="col-sm-6 col-xs-12">
				<strong>{{ vendor.name }}</strong>
				<br>
				{{ vendor.vendor_id }}
			</div>

			<div class="col-sm-6 col-xs-12">
				<button class="btn btn-default" @click="goToStores">Lojas</button>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6 col-sm-9 col-xs-12">
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

			<div class="col-xs-12 text-center" style="magin-top: 15px;">
				<button class="btn btn-danger">Deletar</button>
				<router-link class="btn btn-default"
					:to="{ path: '/adm/vendors' }"
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
		components: {
			Uploader
		},
		created() {
			if(!this.vendors.length) {
				this.loadVendors()
			} else {
				this.mutableVendors = this.vendors
				this.vendor = this.getStoreVendor()
				this.$emit('vendorTargetChanged', this.vendor)
			}
		},
		data() {
			return {
				vendorID: this.$route.params.subArea,
				mutableVendors: this.vendors,
				vendor: {}
			}
		},
		methods: {
			getStoreVendor() {
				return _.find(this.mutableVendors, {
					vendor_id: this.vendorID
				})
			},
			loadVendors() {
				this.loading = true
				this.$store.dispatch('load-vendors')
			},
			goToStores() {
				this.$router.push({
					path: `/adm/branchs/${ this.vendorID }`
				})
			}
		},
		watch:{
			vendors(newValue, oldValue) {
				this.mutableVendors = newValue
				this.vendor = this.getStoreVendor()
				this.$emit('vendorTargetChanged', this.vendor)
			}
		},
		computed: {
			vendors() {
				this.loading = false
				return this.$store.getters.vendors
			}
		}
	}
</script>

<style lang='less'>

</style>