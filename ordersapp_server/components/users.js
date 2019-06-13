const db = require('../helpers/dbConnector')
const utils = require('../helpers/utils')

module.exports = {
	salvar: (data, callback) => {
		db.query(
			`INSERT INTO users 
				(nome, celular, email)
			VALUES(
				${ "'" + data.nome + "', '" + data.celular + "', '"
				+ data.email + "'" }
			)`
		)

		utils.getLastID().then((result) => {
			getUser(result[0].lastID).then((result) => {
				let user = result[0]
				callback(user)
			})
		})

	}
}

function getUser(userID) {
	return db.query(
		`SELECT * FROM users WHERE idusers = ${userID}`
	)
}