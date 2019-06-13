<template>
	<div class="container-fluid">
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">Razão Social</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#/adm">Dashboard</a></li>
						<li><a href="#">Configurações</a></li>
						<li><router-link :to="{ path: '/adm/branchs'}">Lojas</router-link></li>
						<li><a href="#">Suporte</a></li>
					</ul>
					<form class="navbar-form navbar-right">
						<input type="text" class="form-control" placeholder="Search...">
					</form>
				</div>
			</div>
		</nav>

		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="#">Estatísticas</a></li>
					<li><a href="#">Pedidos</a></li>
					<li><a href="#">Relatórios</a></li>
				</ul>
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<dashboard v-if="area == undefined"></dashboard>
				<data-config v-if="area == 'data'"></data-config>
				<branchs v-if="area == 'branchs'" :subArea="subArea"></branchs>
				<vendors v-if="area == 'vendors'" :subArea="subArea"></vendors>
			</div>
		</div>
	</div>
</template>

<script>
	import Dashboard from '../admin/dashboard'
	import DataConfig from '../admin/data'
	import Branchs from '../admin/branchs/branchs'
	import Vendors from '../admin/vendors/vendors'

	export default {
		components: {
			Dashboard,
			DataConfig,
			Branchs,
			Vendors
		},
		created() {
			this.area = this.$route.params.area
			this.subArea = this.$route.params.subArea
		},
		data() {
			return {
				area: undefined
			}
		},
		watch: {
			'$route'(to, from) {
				this.area = to.params.area
			}
		},
		methods: {

		},
		computed: {
			
		}
	}
</script>

<style lang='less'>
	/*
	* Base structure
	*/
	/*
	* Global add-ons
	*/
	.sub-header {
		padding-bottom: 10px;
		border-bottom: 1px solid #eee;
	}

	/*
	* Top navigation
	* Hide default border to remove 1px line.
	*/
	.navbar-fixed-top {
		border: 0;
	}

	/*
	* Sidebar
	*/
	/* Hide for mobile, show later */
	.sidebar {
		display: none;
	}
	@media (min-width: 768px) {
		.sidebar {
			position: absolute !important;
			top: 51px;
			left: 0;
			z-index: 1000;
			display: block;
			overflow-x: hidden;
			overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
			background-color: #f5f5f5;
			border-right: 1px solid #eee;
		}
	}

	/* Sidebar navigation */
	.nav-sidebar {
		li {
			a {
				padding-right: 20px;
				padding-left: 20px;
			}
		}
		
		.active {
			a {
				&:hover {
					color: #fff;
					background-color: #428bca;
				}
				&:focus {
					color: #fff;
					background-color: #428bca;
				}
			}
		}
	}
	/*
	* Main content
	*/
	.main {
		padding: 20px;

		.page-header {
			margin-top: 0;
		}
	}

	@media (min-width: 768px) {
		.main {
			padding-right: 40px;
			padding-left: 40px;
			margin-top: 38px;
		}
	}
	/*
	* Placeholder dashboard ideas
	*/
	.placeholders {
		margin-bottom: 30px;
		text-align: center;
		
		h4 {
			margin-bottom: 0;
		}
	}

	.placeholder {
		margin-bottom: 20px;

		img {
			display: inline-block;
			border-radius: 50%;
		}
	}
</style>