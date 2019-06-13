<template>
	<div class="list-vendors">
		<ul class="list-group col-md-7">
			<li class="list-group-item hover-list-itens" @click="vendorSelected(vendor.vendor_id)" v-for="vendor in mutableVendors" :key="vendor_id">
				{{ vendor.name }}
			</li>
		</ul>
	</div>
</template>

<script>
	export default {
		created() {
			this.loadVendors()
		},
		data() {
			return {
				loading: false,
				mutableVendors: this.vendors,
			}
		},
		methods: {
			vendorSelected(vendorID) {
				this.$router.push({ path: `/adm/vendors/${ vendorID }` })
			},
			loadVendors() {
				this.loading = true
				this.$store.dispatch('load-vendors')
			}
		},
		watch:{
			vendors(newValue, oldValue) {
				this.mutableVendors = newValue
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
	.list-vendors {
		
	}
</style>