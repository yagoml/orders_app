<template>
	<div class="branchs">
		<h4 class="page-header" v-if="!mutableBranchID">
			<span v-if="vendor && isGuid(mutableVendorID) && !mutableBranchID">
				Lojas - <strong>{{ vendor.name }}</strong>
				<br>
				{{ vendor.vendor_id }}
			</span>
			<span v-if="mutableVendorID == 'new'">Nova Loja</span>
		</h4>

		<div class="branchs-content">
			<list-branchs v-if="isGuid(mutableVendorID) && !mutableBranchID"
				:vendorID="mutableVendorID"
				:vendor="vendor"
			></list-branchs>
			<new-branch v-if="mutableVendorID == 'new'" @branchTargetChanged="branchTargetChanged"></new-branch>
			<branch-edition v-if="mutableBranchID"
				:branchID="mutableBranchID"
				:vendorID="mutableVendorID"
				@branchTargetChanged="branchTargetChanged"
			></branch-edition>
		</div>
	</div>
</template>

<script>
	import Utils from '../../../helpers/utils'
	import ListBranchs from './list-branchs'
	import NewBranch from './new-branch'
	import BranchEdition from './branch-edition'

	export default {
		props: ['vendorID', 'branchID'],
		components: {
			ListBranchs,
			NewBranch,
			BranchEdition
		},
		created() {
			this.loadVendorBranchs()
			this.loadVendors()
		},
		data() {
			return {
				mutableVendorID: this.vendorID,
				mutableBranchID: this.branchID,
				selectedVendorBranch: {},
				mutableVendors: this.vendors,
				vendor: this.vendor
			}
		},
		methods: {
			branchTargetChanged(vendorBranch) {
				this.selectedVendorBranch = vendorBranch
			},
			getSelectedVendorBranch() {
				return _.find(this.vendorBranchs, {
					vendor_branch_id: this.mutableBranchID
				})
			},
			isGuid(mutableVendorID) {
				return Utils.isGuid(mutableVendorID)
			},
			getStoreVendor() {
				return _.find(this.mutableVendors, {
					vendor_id: this.vendorID
				})
			},
			loadVendors() {
				this.loading = true
				this.$store.dispatch('load-vendors')
			},
			loadVendorBranchs() {
				this.$store.dispatch('load-vendor-branchs', {
					vendorID: this.vendorID
				})
			}
		},
		watch: {
			'$route'(to, from) {
				this.mutableVendorID = to.params.subArea
				this.mutableBranchID = to.params.routeP1
			},
			vendors(newValue, oldValue) {
				this.mutableVendors = newValue
				this.vendor = this.getStoreVendor()
			},
			vendorBranchs(newValue, oldValue) {
				this.selectedVendorBranch = this.getSelectedVendorBranch()
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
	.branchs {
		
	}
</style>