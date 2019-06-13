<template>
	<window-popup
		ref="windowPop"
		@windowAction="windowAction"
		@orderCancel="orderCancel(order.idpedidos)"
		width="50%"
		:title="popupTitle"
		:buttonsTexts="{ close: 'Fechar', action: 'Concluir' }"
		:extraButtons="[{ text: 'Cancelar', class: 'btn btn-danger', trigger: 'orderCancel' }]"
	>
		<div class="row adm-order-popup">
			<div class="col-sm-6 col-xs-12">
				<div class="field-label">Cliente: <strong>{{ order.nome }}</strong></div>
				<div class="field-label">Horário Pedido: <strong>{{ order.horario_pedido }}</strong></div>
				<div class="field-label">Horário Desejado: <strong>{{ order.horario_entrega }}</strong></div>
				<div class="field-label">Endereço Entrega: <strong>{{ order.end_entrega }}</strong></div>
				<div class="field-label">Observações: <strong>{{ order.observacoes }}</strong></div>
			</div>

			<div class="col-sm-6 col-xs-12">
				<div class="field-label">Refeições:
					<strong>
						<ul class="food-list">
							<li v-for="food in orderFoods" :key="food.idrefeicoes">
								{{ food.nome }}
							</li>
						</ul>
					</strong>
				</div>
				<div class="field-label">Valor: R$ <strong>{{ (parseFloat(order.preco) || 0).toFixed(2).replace('.', ',') }}</strong></div>
			</div>
		</div>
	</window-popup>
</template>

<script>
	import WindowPopup from '../window-popup'
	import Utils from '../../helpers/utils'

	export default {
		components: {
			WindowPopup
		},
		props: ['order'],
		created() {
			this.utils = Utils
		},
		data() {
			return {

			}
		},
		methods: {
			open() {
				this.$store.dispatch('load-order-foods', {
					pedidoID: this.order.idpedidos
				})

				this.$refs.windowPop.open()
			},
			windowAction() {
				if(confirm(`Concluir o pedido ${ this.order.idpedidos }?`)) {
					this.$store.dispatch('complete-order', {
						pedidoID: this.order.idpedidos
					})
					this.$emit('orderCompleted', this.order.idpedidos)
				}
			},
			orderCancel() {
				if(confirm(`Cancelar o pedido ${ this.order.idpedidos }?`)) {
					this.$store.dispatch('cancel-order', {
						pedidoID: this.order.idpedidos
					})
					this.$emit('orderCancel', this.order.idpedidos)
				}
			}
		},
		watch: {
			orderFoods: function(newValue, oldValue) {
				this.orderFoods = newValue[0]
			}
		},
		computed: {
			popupTitle() {
				return ('Pedido ' + this.order.idpedidos + ': ' + this.order.quantidade + ' ' + this.order.nome_prato + '(s)')
			},
			orderFoods: {
				get: function () {
					return this.$store.getters.orderFoods
				},
				set: function (newValue) {

				}
			}
		}
	}
</script>

<style lang="less">
	.adm-order-popup {
		.field-label {
			width: fit-content;
			padding: 5px;
			text-align: left;

			.food-list {
				list-style: decimal;
			}
		}
	}
</style>