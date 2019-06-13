<template>
	<div class="list-branchs">
		<div class="list-branchs-content">
			<ul class="list-group col-md-7">
				<li class="list-group-item hover-list-itens" @click="productSelected(category.categoryId)" v-for="category in branchProducts" :key="categoryId">
					{{ category.name }}
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
	export default {
		props: [ 'branchID' ],
		created() {
			// this.loadVendorBranchs()
			this.loadBranchProducts()
		},
		data() {
			return {
				loading: false
			}
		},
		methods: {
			productSelected(vendorBranchID) {
				this.$router.push({ path: `/adm/branchs/${ this.vendor.vendor_id }/${ vendorBranchID }` })
			},
			loadVendorBranchs() {
				this.loading = true

				this.$store.dispatch('load-vendor-branchs', {
					vendorID: this.vendorID
				})
			},
			loadBranchProducts() {
				this.loading = true
				this.$store.dispatch('load-branch-products', {
					branchID: this.branchID
				})
			},
			getStoreVendor() {
				return _.find(this.mutableVendors, {
					vendor_id: this.vendorID
				})
			},
			getVendorBranch() {
				return _.find(this.vendorBranchs, {
					vendor_branch_id: this.mutableBranchID
				})
			}
		},
		watch:{
			vendorBranchs(newValue, oldValue) {

			},
			branchProducts(newValue, oldValue) {

			}
		},
		computed: {
			vendorBranchs() {
				this.loading = false
				return this.$store.getters.vendorBranchs
			},
			branchProducts() {
				this.loading = false
				return this.$store.getters.branchProducts
			}
		}
	}
</script>

<style lang='less'>

</style>