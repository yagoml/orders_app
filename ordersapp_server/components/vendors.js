const _ = require('lodash')
const db = require('../helpers/dbConnector')
const http = require('http')
const utils = require('../helpers/utils')

const ratingTypes = {
	g: 'general',
	d: 'delivery',
	p: 'product',
	ar: 'allRight'
}

const weekDays = [
	'Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'
]

const initialEnglishWeekDays = [
	'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'
]

module.exports = {
	getVendors: () => {
		query = `select * from vendors`

		return db.query(query)
	},
	getVendor: (vendorID) => {
		let query =
			`select * from vendors where vendor_id = '${ vendorID }'`

		return db.query(query)
	},
	getVendorsBranchsByCity: (cityID) => {
		let query =
			`select vb.*, v.vendor_id
			from vendor_branchs vb
			join vendors v on vb.vendor_id = v.vendor_id
			where vb.city_id = ${ cityID }`

		let promise = new Promise((resolve, reject) => {
			let vendors = []
			let promises = []

			db.query(query).then(async (result) => {
				result.forEach((vendor, i) => {
					promises.push(new Promise(async (res, rej) => {
						let vendorInfosPromises = []

						vendorInfosPromises.push(
							getVendorBranchOperation(vendor.vendor_branch_id).then((vendorOperation) => {
								let operation = vendorOperation.find((op) => {
									return op.dayWeek == getWeekDay()
								})

								if(operation) {
									vendor.operation = operation
									vendor.open = operation.open
									vendor.close = operation.close
								}
							})
						)

						vendorInfosPromises.push(
							getVendorBranchRating(vendor.vendor_branch_id).then((vendorRating) => {
								if(!_.isEmpty(vendorRating))
									vendor.rating = vendorRating.general.totalMedia
							})
						)

						await Promise.all(vendorInfosPromises)

						vendors[i] = {
							id: vendor.vendor_branch_id,
							name: vendor.name,
							avatar: vendor.avatar,
							banner: vendor.banner,
							openTime: vendor.open,
							closeTime: vendor.close,
							deliveryTime: vendor.delivery_time_min + ' - ' + vendor.delivery_time_max,
							isOpen: isOpen(vendor) && !vendor.temp_closed,
							isOpenToday: isOpenToday(vendor),
							rating: vendor.rating
						}

						res(vendors[i])
					}))
				})

				await Promise.all(promises)
				resolve(vendors)
			})
		})

		return promise
	},
	getVendorBranchFees: async (vendorBranchID) => {
		let query =
			`select * from vendor_fees where vendor_branch_id = '${ vendorBranchID }'`

		let vendorBranchFees = []

		let feesPromise = new Promise((resolve, reject) => {
			db.query(query).then(async (feesData) => {
				let cepPromises = []

				feesData.forEach((fee) => {
					let vendorFee = utils.toCamelCase(fee)

					cepPromises.push(new Promise((res, rej) => {
						getCepData(fee.cep).then((cepData) => {
							vendorFee.location = {
								neighborhood: cepData.bairro,
								city: cepData.cidade,
								state: cepData.estado,
								latitude: cepData.latitude,
								longitude: cepData.longitude
							}

							vendorBranchFees.push(vendorFee)
							res(vendorFee)
						})
					}))
				})

				await Promise.all(cepPromises)
				resolve(vendorBranchFees)
			})
		})

		return feesPromise
	},
	getVendorBranchRating: (vendorBranchID) => {
		return getVendorBranchRating(vendorBranchID)
	},
	getVendorBranchPaymentOptions: (vendorBranchID) => {
		let query = `
			select distinct * from card_options co
			join cards c on co.card_id = c.card_id
			where vendor_branch_id = '${ vendorBranchID }'
		`

		let paymentOptions = []

		let promise = new Promise((resolve, reject) => {
			db.query(query).then((result) => {
				result.forEach((paymentOption) => {
					paymentOptions.push(
						utils.toCamelCase(paymentOption)
					)
				})

				resolve(paymentOptions)
			})
		})

		return promise
	},
	getVendorBranchs: (vendorID) => {
		query =
			`select * from vendor_branchs where vendor_id = '${ vendorID }'`

		return db.query(query)
	},
	getVendorBranchOperation: (vendorBranchID) => {
		return getVendorBranchOperation(vendorBranchID)
	},
	setBranchBanner: (vendorBranchID, bannerPath) => {
		query =
			`update vendor_branchs set banner = '${ bannerPath }' where vendor_branch_id = '${ vendorBranchID }'`

		return db.query(query)
	},
	getBranchProducts: (vendorBranchID) => {
		let query = `
			SELECT ps.*, pc.category_id, pc.name AS category_name, pc.image AS category_image, pc.description AS 
			category_description, pc.active AS category_active, pt.type_id, pt.name AS type_name,
			pt.description AS type_description, pt.image AS type_image, pt.active AS type_active, p.*
			FROM product_sizes ps
			JOIN products p ON p.product_id = ps.product_id
			JOIN product_types pt ON p.type_id = pt.type_id
			JOIN product_categories pc ON pt.category_id = pc.category_id
			WHERE p.vendor_branch_id = '${ vendorBranchID }'
		`

		return new Promise((resolve, reject) => {
			db.query(query).then((result) => {
				processProductsData(result).then((categories) => {
					resolve(categories)
				})
			})
		})
	},
	getProductInfos: (productID) => {
		return new Promise(async (resolve, reject) => {
			let subPromises = []
			let sizes = []
			let additionals = []

			let sizesQuery = `
				SELECT * FROM product_sizes WHERE product_id = '${ productID }' ORDER BY price ASC
			`
			let additionalsQuery = `
				SELECT * FROM product_additional WHERE product_id = '${ productID }' ORDER BY price ASC
			`
			let sizesAdditionalQuery = 'SELECT * FROM product_additional WHERE product_size_id = '

			subPromises.push(
				db.query(sizesQuery).then((result) => {
					result.forEach((res) => {
						sizes.push(utils.toCamelCase(res))
					})
				})
			)

			subPromises.push(
				db.query(additionalsQuery).then((result) => {
					result.forEach((res) => {
						additionals.push(utils.toCamelCase(res))
					})
				})
			)

			// wait for 'sizes' data
			await subPromises[0]

			sizes.forEach((productSize, i) => {
				if(i == 0)
					sizesAdditionalQuery += `'${ productSize.productSizeId }'`
				else
					sizesAdditionalQuery += ` OR product_size_id = '${ productSize.productSizeId }'`
			})

			subPromises.push(
				db.query(sizesAdditionalQuery).then((result) => {
					result.forEach((res) => {
						additionals.push(utils.toCamelCase(res))
					})
				})
			)

			await Promise.all(subPromises)
			
			resolve({
				sizes: sizes,
				additionals: additionals
			})
		})
	}
}

const processProductsData = (result) => {
	let processedData = []
	let categories = processCategories(_.uniqBy(result, 'category_id'))
	let productsPromise = processProducts(_.uniqBy(result, 'product_id'))

	return new Promise((resolve, reject) => {
		productsPromise.then((products) => {
			let productTypes = processProductTypes(_.uniqBy(result, 'type_id'), products, result)
	
			categories.forEach((category) => {
				processedData.push({
					categoryId: category.categoryId,
					name: category.name,
					description: category.description,
					image: category.image,
					productTypes: _.filter(productTypes, (productType) => {
						return productType.category_id == category.category_id
					})
				})
			})

			resolve(processedData)
		})
	})
}

const getCepData = (cep, resolv = false) => {
	let options = {
		host: 'www.cepaberto.com',
		path: `/api/v3/cep?cep=${ cep }`,
		headers: {
			Authorization: `Token 7011d39092806373d1bed8dd7f72ea06`
		}
	}

	let reqPromise = new Promise((resolve, reject) => {
		if(resolv)
			resolve = resolv

		let req = http.get(options, (res) => {
			console.log('STATUS: ' + res.statusCode)
			console.log('HEADERS: ' + JSON.stringify(res.headers))
			let bodyChunks = []

			res.on('data', (chunk) => {
				bodyChunks.push(chunk)
			}).on('end', () => {
				if(res.statusCode == 200) {
					let body = Buffer.concat(bodyChunks)
					resolve(JSON.parse(body.toString()))
				} else {
					getCepData(cep, resolve)
				}
			})
		})

		req.on('error', (e) => {
			console.log('ERROR: ' + e.message)
		})
	})

	return reqPromise
}

const calcMediaRating = (vendorRating) => {
	let keys = Object.keys(vendorRating)
	let totalQntVotes = 0

	keys.forEach((key) => {
		if(!vendorRating[key].totalMedia)
			vendorRating[key].totalMedia = 0
			vendorRating[key].qntVotes = 0

		vendorRating[key].list.forEach((rating) => {
			vendorRating[key].totalMedia += rating.note
			vendorRating[key].qntVotes++

			if(rating.type == 'g') {
				totalQntVotes++
			}
		})

		vendorRating.totalQntVotes = totalQntVotes

		let media = vendorRating[key].totalMedia
		let qntVotes = vendorRating[key].qntVotes

		vendorRating[key].totalMedia = (media / qntVotes).toFixed(1)
	})

	return vendorRating
}

const getVendorBranchOperation = (vendorBranchID) => {
	let query = `
		select * from vendors_operation where vendor_branch_id = '${ vendorBranchID }'
		order by day_week asc
	`

	let vendorOperation = []

	let promise = new Promise((resolve, reject) => {
		db.query(query).then((result) => {
			result.forEach((operation) => {
				vendorOperation.push({
					day: weekDays[operation.day_week - 1],
					open: operation.open,
					close: operation.close,
					dayWeek: operation.day_week
				})
			})

			resolve(vendorOperation)
		})
	})

	return promise
}

const getWeekDay = () => {
	let agora = new Date()
	let weekDay = agora.toString().substr(0, 3)

	weekDay = initialEnglishWeekDays.findIndex((value) => {
		return value == weekDay.toLowerCase()
	})

	return weekDay + 1
}

const getVendorBranchRating = (vendorBranchID) => {
	let query =
		`select r.*, u.name as user_name, u.image as user_img
		from rating r
		join users u on u.user_id = r.user_id
		where r.vendor_branch_id = '${ vendorBranchID }'`

	let vendorRating = {}

	let promise = new Promise((resolve, reject) => {
		let promises = []

		db.query(query).then(async (result) => {
			result.forEach((rating) => {
				let qntOrdersQuery = `
					select count(*) from orders
					where user_id = '${ rating.user_id }' and vendor_branch_id = '${ vendorBranchID }'
				`

				let ordersProductsQuery = `
					select op.comments, op.quantity, p.name as product_name, pt.name as product_type_name
					from order_products op
					join products p on op.product_id = p.product_id
					join product_types pt on pt.type_id = p.type_id
					where order_id = '${ rating.order_id }'
				`

				promises.push(
					new Promise((resolve1, reject1) => {
						db.query(qntOrdersQuery).then((qntOrders) => {
							rating.qntOrders = parseInt(qntOrders[0].count)

							db.query(ordersProductsQuery).then((orderProducts) => {
								rating.orderProducts = orderProducts

								if(vendorRating[ratingTypes[rating.type]])
									vendorRating[ratingTypes[rating.type]].list.push(
										utils.toCamelCase(rating)
									)
								else
									vendorRating[ratingTypes[rating.type]] = {
										list: [ utils.toCamelCase(rating) ]
									}

								resolve1(vendorRating[ratingTypes[rating.type]])
							})
						})
					})
				)
			})

			await Promise.all(promises)
			if(!_.isEmpty(vendorRating))
				vendorRating = calcMediaRating(vendorRating)

			resolve(vendorRating)
		})
	})

	return promise
}

const isOpenToday = (vendor) => {
	if(vendor.operation) {
		let agora = new Date()
		let horas = agora.getHours()
		let minutos = agora.getMinutes()
		let vendorOpenTime = vendor.open.split(':')
		let vendorOpenHours = parseInt(vendorOpenTime[0])
		let vendorOpenMinutes = parseInt(vendorOpenTime[1])
		let vendorCloseTime = vendor.close.split(':')
		let vendorCloseHours = parseInt(vendorCloseTime[0])
		let vendorCloseMinutes = parseInt(vendorCloseTime[1])

		if(vendorCloseHours > horas) {
			return false
		} else if(vendorCloseHours == horas) {
			if(vendorCloseMinutes > minutos) {
				return false
			}
		}
	} else {
		return false
	}

	return true
}

const isOpen = (vendor) => {
	if(vendor.operation) {
		let agora = new Date()
		let horas = agora.getHours()
		let minutos = agora.getMinutes()
		let vendorOpenTime = vendor.open.split(':')
		let vendorOpenHours = parseInt(vendorOpenTime[0])
		let vendorOpenMinutes = parseInt(vendorOpenTime[1])
		let vendorCloseTime = vendor.close.split(':')
		let vendorCloseHours = parseInt(vendorCloseTime[0])
		let vendorCloseMinutes = parseInt(vendorCloseTime[1])

		if(vendorOpenHours > horas && vendorCloseHours < horas) {
			return true
		} else if(vendorOpenHours == horas) {
			if(vendorOpenMinutes > minutos) {
				return true
			}
		} else if(vendorCloseHours == horas) {
			if(vendorCloseMinutes < minutos) {
				return true
			}
		}
	}

	return false
}

const processProductTypes = (productTypes, products, sizes) => {
	let processedProductTypes = []

	productTypes.forEach((productType) => {
		processedProductTypes.push({
			typeId: productType.type_id,
			name: productType.type_name,
			description: productType.type_description,
			image: productType.type_image,
			active: productType.type_active,
			categoryId: productType.category_id,
			products: _.filter(products, (product) => {
				return product.typeId == productType.type_id
			})
		})
	})

	return processedProductTypes
}

const processCategories = (productCategories) => {
	let processedCategories = []

	productCategories.forEach((productCategory) => {
		processedCategories.push({
			categoryId: productCategory.category_id,
			name: productCategory.category_name,
			description: productCategory.category_description,
			image: productCategory.category_image,
			active: productCategory.category_active
		})
	})

	return processedCategories
}

const processProducts = (products) => {
	return new Promise(async (resolve, reject) => {
		let processedProducts = []
		let subPromises = []

		products.forEach(async (product, i) => {
			let sizesQuery = `
				SELECT * FROM product_sizes WHERE product_id = '${ product.product_id }' ORDER BY price ASC
			`

			subPromises.push(
				new Promise((res, rej) => {
					db.query(sizesQuery).then((result) => {
						product.priceRange = result[0].price + ' - ' + result[result.length - 1].price
						res(product.priceRange)
					})
				})
			)

			await subPromises[i]

			processedProducts.push({
				productId: product.product_id,
				name: product.name,
				description: product.description,
				image: product.image,
				active: product.active,
				typeId: product.type_id,
				priceRange: product.priceRange
			})
		})

		await Promise.all(subPromises)
		resolve(processedProducts)
	})
}