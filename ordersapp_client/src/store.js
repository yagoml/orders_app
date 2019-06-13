import Vue from 'vue'
import Vuex from 'vuex'
import Request from './helpers/request'

Vue.use(Vuex)

const SERVER_URL = 'http://localhost:666/'

const state = {
	serverURL: SERVER_URL,
	vendorBranchs: [],
	vendors: [],
	branchProducts: []
}

const mutations = {
	'set-vendor-branchs'(state, vendorBranchs) {
		state.vendorBranchs = vendorBranchs
	},
	'set-vendors'(state, vendors) {
		state.vendors = vendors
	},
	'set-branch-products'(state, branchProducts) {
		state.branchProducts = branchProducts
	}
}

const actions = {
	'load-vendor-branchs'(context, data) {
		Request.post({
			route: `${ SERVER_URL }vendorBranchs`,
			data: data,
			callback: (vendorBranchs) =>
				context.commit('set-vendor-branchs', vendorBranchs)
		})
	},
	'load-vendors'(context, data) {
		Request.post({
			route: `${ SERVER_URL }vendors`,
			data: data,
			callback: (vendors) =>
				context.commit('set-vendors', vendors)
		})
	},
	'load-branch-products'(context, data) {
		Request.post({
			route: `${ SERVER_URL }branchProducts`,
			data: data,
			callback: (products) =>
				context.commit('set-branch-products', products)
		})
	}
}

export default new Vuex.Store({
	state,
	getters: {
		serverURL: state => state.serverURL,
		vendorBranchs: state => state.vendorBranchs,
		vendors: state => state.vendors,
		branchProducts: state => state.branchProducts
	},
	mutations,
	actions
})