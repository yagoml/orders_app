const _ = require('lodash')

module.exports = {
	toCamelCase: (obj) => {
		return _.mapKeys(obj, (v, k) => _.camelCase(k))
	}
}