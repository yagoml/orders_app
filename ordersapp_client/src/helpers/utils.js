function formatBRMoney(num) {
	return parseFloat(num).toFixed(2).replace('.', ',')
}

export default {
	formatBRMoney: formatBRMoney,
	isGuid: str => {
		const guidRegex = new RegExp(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
		return guidRegex.test(str)
	}
}