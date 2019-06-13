<template>
	<div class="col-xs-12 orders">
		<div>
			<router-link :to="{ path: '/adm/pedidos'}"><button class="btn btn-default" :style="{ border: btnStyles.todos }">Todos</button></router-link>
			<router-link :to="{ path: '/adm/pedidos/em_aberto'}"><button class="btn btn-warning" :style="{ border: btnStyles.em_aberto }">Em Aberto</button></router-link>
			<router-link :to="{ path:  '/adm/pedidos/concluido'}"><button class="btn btn-success" :style="{ border: btnStyles.concluido }">Concluídos</button></router-link>
			<router-link :to="{ path:  '/adm/pedidos/cancelado'}"><button class="btn btn-danger" :style="{ border: btnStyles.cancelado }">Cancelados</button></router-link>
		</div>

		<div class="table-responsive table-wrapper">
			<table class="table table-striped table-hover">
				<thead>
					<th>ID</th>
					<th>Usuário</th>
					<th>Horário Pedido</th>
					<th>Horário Entrega</th>
					<th>Tipo Pedido</th>
					<th>Qtd.</th>
					<th>Valor</th>
				</thead>
				<tbody>
					<tr v-for="order in mutableOrders"
						:key="order.idpedidos"
						@click="openAdmOrderPopup(order)"
					>
						<td>{{ order.idpedidos }}</td>
						<td>{{ order.nome }}</td>
						<td>{{ order.horario_pedido }}</td>
						<td>{{ order.horario_entrega }}</td>
						<td>{{ order.idtipos_pedido + ' - ' + order.nome_prato }}</td>
						<td>{{ order.quantidade }}</td>
						<td>R$ {{ (parseFloat(order.preco) || 0).toFixed(2).replace('.', ',') }}</td>
					</tr>
				</tbody>
			</table>

			<adm-order-popup ref="AdmOrderPop"
				:order="selectedOrder"
				@orderCompleted="removeOrder"
				@orderCancel="removeOrder"
			></adm-order-popup>
		</div>
	</div>
</template>

<script>
	import _ from 'lodash'
	import AdmOrderPopup from './adm-order-popup'

	export default {
		components: {
			AdmOrderPopup
		},
		created() {
			this.loadOrders()
			this.page++
			this.desactivateBtns()
			this.activeBtn(this.$route.params.status)
		},
		destroyed() {
			this.eventScroll(false)
		},
		data() {
			return {
				page: 1,
				loading: false,
				finish: false,
				lastScroll: 0,
				status: this.$route.params.status,
				selectedOrder: 0,
				mutableOrders: this.orders,
				selectedBtn: '3px solid #337ab7',
				normalBtnBoder: '1px solid #ccc',
				btnStyles: {
					todos: '3px solid #337ab7',
					em_aberto: '1px solid #ccc',
					concluido: '1px solid #ccc',
					cancelado: '1px solid #ccc'
				}
			}
		},
		computed: {
			orders() {
				return this.$store.getters.orders
			}
		},
		mounted() {
			this.eventScroll()
		},
		methods: {
			loadOrders() {
				this.loading = true

				this.$store.dispatch('load-orders', {
					filter: this.status,
					page: this.page
				})
			},
			openAdmOrderPopup(order) {
				this.selectedOrder = order
				
				setTimeout(() => {
					this.$refs.AdmOrderPop.open()
				}, 100)
				
			},
			removeOrder(orderID) {
				let index = _.findIndex(this.mutableOrders, { idpedidos: orderID })
				this.mutableOrders.splice(index, 1)
			},
			activeBtn(status) {
				let filter = 'todos'

				if(typeof this.$route.params.status != 'undefined')
					filter = this.$route.params.status

				this.btnStyles[filter] = this.selectedBtn
			},
			desactivateBtns() {
				_.each(this.btnStyles, (value, key, obj) => {
					obj[key] = this.normalBtnBoder
				})
			},
			handleScroll() {
				if(!this.loading && !this.finish) {
					let scrollTop = document.getElementsByClassName('table-wrapper')[0].scrollTop
					let tableWrapHeight = document.getElementsByClassName('table-wrapper')[0].clientHeight
					let tableHeight = document.getElementsByClassName('table')[0].clientHeight
					
					if(scrollTop > this.lastScroll) {
						this.lastScroll = scrollTop
						// Chamar mais dados quando scroll estiver 5% do final
						const percentToCall = 5
						let pxToCall = (tableHeight * percentToCall) / 100

						if((tableWrapHeight + scrollTop + pxToCall) > tableHeight) {
							this.loadOrders()
							this.page++
						}
					}
				}
			},
			eventScroll(add = true) {
				let $tableWrapper = document.getElementsByClassName('table-wrapper')[0]
				
				if(add)
					$tableWrapper.addEventListener('scroll', this.handleScroll)
				else
					$tableWrapper.removeEventListener('scroll', this.handleScroll)
			}
		},
		watch: {
			orders(newValue, oldValue) {
				this.finish = (newValue.length < 20 && this.page > 2)

				if(_.isEmpty(this.mutableOrders)) {
					this.mutableOrders = newValue
					this.lastScroll = 0
					this.eventScroll()
				} else {
					this.mutableOrders = this.mutableOrders.concat(newValue)
				}

				this.loading = false
			},
			'$route'(to, from) {
				this.status = to.params.status
				this.page = 1
				this.mutableOrders = []
				this.loadOrders()
				this.page++
				this.desactivateBtns()
				this.activeBtn(to.params.status)
			}
		}
	}
</script>

<style lang="less">
	.orders {
		margin-top: 15px;
		
		.table-wrapper {
			overflow: auto;
			max-height: ~"calc(100vh - 55px)";

			table {
				th {
					padding: 8px;
					height: 40px;
				}
				tr {
					cursor: pointer;
				}
			}

			.selected-filter {
				text-align: center;
				font-size: 20px;
			}
		}
	}
</style>