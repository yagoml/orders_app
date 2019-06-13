<template>
	<div class="list-branchs">
		<div class="list-branchs-content">
			<ul class="list-group col-md-7">
				<li class="list-group-item hover-list-itens" @click="branchSelected(vendorBranch.vendor_branch_id)" v-for="vendorBranch in mutableVendorBranchs" :key="vendor_branch_id">
					{{ vendorBranch.name }}
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
	export default {
		props: [ 'vendorID', 'vendor' ],
		created() {
			this.loadVendorBranchs()
			this.loadVendors()
		},
		data() {
			return {
				loading: false,
				mutableVendorBranchs: this.vendorBranchs,
				mutableVendors: this.vendors,
				mutableVendor: this.vendor
			}
		},
		methods: {
			branchSelected(vendorBranchID) {
				this.$router.push({ path: `/adm/branchs/${ this.vendor.vendor_id }/${ vendorBranchID }` })
			},
			loadVendorBranchs() {
				this.loading = true

				this.$store.dispatch('load-vendor-branchs', {
					vendorID: this.vendorID
				})
			},
			loadVendors() {
				this.loading = true
				this.$store.dispatch('load-vendors')
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
				this.mutableVendorBranchs = newValue
			},
			vendors(newValue, oldValue) {
				this.mutableVendors = newValue
				this.mutableVendor = this.getStoreVendor()
			}
		},
		computed: {
			vendorBranchs() {
				this.loading = false
				return this.$store.getters.vendorBranchs
			},
			vendors() {
				this.loading = false
				return this.$store.getters.vendors
			}
		}
	}
</script>

<style lang='less'>

</style>