<template>
	<div class="vendors">
		<h4 class="page-header vendors-header" v-if="!isGuid(branchID)">
			<span v-if="!branchID">Estabelecimentos</span>
			<span v-if="branchID == 'new'">Novo Estabelecimento</span>
		</h4>

		<div class="vendors-content">
			<list-vendors v-if="!branchID"></list-vendors>
			<new-vendor v-if="branchID == 'new'" @vendorTargetChanged="vendorTargetChanged"></new-vendor>
			<vendor-edition v-if="isGuid(branchID)" @vendorTargetChanged="vendorTargetChanged"></vendor-edition>
		</div>
	</div>
</template>

<script>
	import Utils from '../../../helpers/utils'
	import ListVendors from './list-vendors'
	import NewVendor from './new-vendor'
	import VendorEdition from './vendor-edition'

	export default {
		props: ['vendorID'],
		components: {
			ListVendors,
			NewVendor,
			VendorEdition
		},
		data() {
			return {
				branchID: this.$route.params.subArea,
				selectedVendor: {}
			}
		},
		methods: {
			vendorTargetChanged(vendor) {
				this.selectedVendor = vendor
			},
			isGuid(branchID) {
				return Utils.isGuid(branchID)
			}
		},
		watch: {
			'$route'(to, from) {
				this.branchID = to.params.subArea
			}
		},
		computed: {
			
		}
	}
</script>

<style lang='less'>
	.vendors {
		.vendors-header {
			margin: 5px 0 15px 0;
		}
	}
</style>