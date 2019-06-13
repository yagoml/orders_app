<template>
	<div class="branchs">
		<h4 class="page-header" v-if="!branchID">
			<span v-if="branchID">
				Produtos - <strong>{{ vendorBranch.name }}</strong>
				<br>
				{{ vendorBranch.vendor_id }}
			</span>
			<span v-if="mutableProductID == 'new'">Novo Produto</span>
		</h4>

		<div class="branchs-content">
			<list-products v-if="isGuid(branchID) && !mutableProductID"
				:branchID="branchID"
			></list-products>

			<new-product v-if="mutableProductID == 'new'" @productTargetChanged="productTargetChanged"></new-product>

			<product-edition v-if="mutableproductID"
				:productID="mutableProductID"
				:branchID="branchID"
				@productTargetChanged="productTargetChanged"
			></product-edition>
		</div>
	</div>
</template>

<script>
	import Utils from '../../../helpers/utils'
	import ListProducts from './list-products'
	import NewProduct from './new-product'
	import ProductEdition from './product-edition'

	export default {
		props: [],
		components: {
			ListProducts,
			NewProduct,
			ProductEdition
		},
		created() {
			// this.loadBranchProducts()
		},
		data() {
			return {
				mutableProductID: null,
				branchID: this.$route.params.subArea
			}
		},
		methods: {
			loadBranchProducts() {
				this.$store.dispatch('load-branch-products', {
					branchID: this.branchID
				})
			},
			isGuid(branchID) {
				return Utils.isGuid(branchID)
			},
		},
		watch: {
			'$route'(to, from) {
				this.branchID = to.params.subArea
				this.mutableProductID = to.params.routeP1
			},
			branchProducts(newValue, oldValue) {
				this.mutableBranchProducts = newValue
			}
		},
		computed: {
			branchProducts() {
				this.loading = false
				return this.$store.getters.branchProducts
			}
		}
	}
</script>

<style lang='less'>
	.products {
		
	}
</style>