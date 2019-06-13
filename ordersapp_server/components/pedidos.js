const db = require('../helpers/dbConnector')
const utils = require('../helpers/utils')

// Número de itens por página default
PER_PAGE_DEF = 20

module.exports = {
	salvar: function(data, callback) {
		data.userID = 1 // Temporário para desenvolvimento

		getFoods(data.selectedFoods).then((refeicoes) => {
			data.price = getPrice(refeicoes).toFixed(2)

			saveOrder(data).then((result) => {
				data.orderID = result[0].idpedidos

				if (data.selectedFoods.length) {
					insertOrderFoods(data)
				}

				getOrder(data.orderID).then((result) => {
					let pedido = result[0]
					pedido.selectedFoods = data.selectedFoods
					callback(pedido)
				})
			})
		})

	},
	fetch: async function(data) {
		let query =
			'SELECT p.idpedidos, p.horario_pedido, p.horario_entrega, p.end_entrega, \
			p.quantidade, p.preco, p.tipos_pedido_idtipos_pedido, u.idusers, u.nome, t.idtipos_pedido, t.nome AS nome_prato, p.observacoes, p.estados_pedido_idestados_pedido \
			FROM pedidos p \
			JOIN users u ON p.users_idusers = u.idusers \
			JOIN tipos_pedido t ON p.tipos_pedido_idtipos_pedido = t.idtipos_pedido'

		if(typeof data.filter != 'undefined') {
			let estado = (await getEstadoPedido(data.filter))[0]
			query += '\ WHERE p.estados_pedido_idestados_pedido = ' + estado.idestados_pedido
		}

		query += `\ ORDER BY horario_pedido ASC LIMIT ${ PER_PAGE_DEF + ' OFFSET ' + (data.page * PER_PAGE_DEF - PER_PAGE_DEF) }`

		return db.query(query)
	},
	refeicoesPedido: async function(pedidoID) {
		let refeicoesPedido = await getOrderFoodsIDs(pedidoID)
		let refeicoesIDs = []

		if(refeicoesPedido.length) {
			refeicoesPedido.forEach(function(ref) {
				refeicoesIDs.push(ref.refeicoes_idrefeicoes)
			})
		} else {
			return []
		}

		return getFoods(refeicoesIDs)
	}
}

function saveOrder(data) {
	return db.query(
		`INSERT INTO pedidos
			(end_entrega, quantidade, tipos_pedido_idtipos_pedido, users_idusers, preco, horario_entrega, observacoes)
		VALUES(${
			"'" + data.deliveryAddress + "', " + data.qnt + ", "
			+ data.orderType + ", " + data.userID + ", " + data.price + ", '"
			+ data.deliverySchedule + "', '" + data.notes + "'"
		})
		RETURNING idpedidos`
	)
}