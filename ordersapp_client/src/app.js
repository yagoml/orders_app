import Vue from 'vue'
import Store from './store'
import Router from './router'

require('style-loader!css-loader!bootstrap/dist/css/bootstrap.min.css')
require('bootstrap')
require('style-loader!css-loader!font-awesome/css/font-awesome.min.css')

import './styles/global.less'

let Restaurant = new Vue({
	el: '#app',
	router: Router,
	store: Store
})