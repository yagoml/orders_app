import Vue from 'vue'
import VueRouter from 'vue-router'
import NewUser from './components/new-user'
import Admin from './components/admin/administration'
import Orders from './components/admin/orders'

const routes = [
	{ path: '/adm/:area?/:subArea?/:routeP1?', component: Admin }
]

Vue.use(VueRouter)

export default new VueRouter({
	routes
})