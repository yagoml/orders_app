const _ = require('lodash')
const db = require('../helpers/dbConnector')
const http = require('http')
const utils = require('../helpers/utils')

module.exports = {
	getBranchProducts: (branchID) => {
		query = `select * from products where branch_id = '${ branchID }'`

		return db.query(query)
	}
}