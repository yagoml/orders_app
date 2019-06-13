const express =  require('express')
const router  = express.Router()
const cors = require('cors')
const bodyParser = require('body-parser')

// Components
const vendors = require('./components/vendors')
const uploads = require('./components/uploads')

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({
	extended: true,
	uploadDir: './uploads'
}))

// Middleware
// router.use(function(req, res, next) {
// 	// Do some shit
// 	next()
// })

function allowAcessControl(res) {
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept')
}

router.options('/vendorsBranchsByCity', cors())
router.post('/vendorsBranchsByCity', getVendorsBranchsByCity)

async function getVendorsBranchsByCity(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorsBranchsByCity(req.body.cityID))
}

router.options('/vendors', cors())
router.post('/vendors', getVendors)

async function getVendors(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendors())
}

router.options('/vendor', cors())
router.post('/vendor', getVendor)

async function getVendor(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendor(req.body.vendorID))
}

router.options('/vendorBranchs', cors())
router.post('/vendorBranchs', getVendorBranchs)

async function getVendorBranchs(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorBranchs(req.body.vendorID))
}

router.options('/branchProducts', cors())
router.post('/branchProducts', getBranchProducts)

async function getBranchProducts(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getBranchProducts(req.body.branchID))
}

router.options('/vendorBranchFees', cors())
router.post('/vendorBranchFees', getVendorBranchFees)

async function getVendorBranchFees(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorBranchFees(req.body.vendorBranchID))
}

router.options('/vendorBranchRating', cors())
router.post('/vendorBranchRating', getVendorBranchRating)

async function getVendorBranchRating(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorBranchRating(req.body.vendorBranchID))
}

router.options('/vendorBranchPaymentOptions', cors())
router.post('/vendorBranchPaymentOptions', getVendorBranchPaymentOptions)

async function getVendorBranchPaymentOptions(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorBranchPaymentOptions(req.body.vendorBranchID))
}

router.options('/vendorBranchOperation', cors())
router.post('/vendorBranchOperation', getVendorBranchOperation)

async function getVendorBranchOperation(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getVendorBranchOperation(req.body.vendorBranchID))
}

router.options('/productInfos', cors())
router.post('/productInfos', getProductInfos)

async function getProductInfos(req, res) {
	allowAcessControl(res)
	res.json(await vendors.getProductInfos(req.body.productID))
}

router.options('/vendorBranchBanner', cors())
router.post('/vendorBranchBanner', uploadBranchBanner)

function uploadBranchBanner(req, res) {
	allowAcessControl(res)
	uploads.save(req, res).then((result) => {
		vendors.setBranchBanner(result.params.vendorBranchID, result.uploadedFiles[0].path)
	})
}

router.options('/uploads/delete', cors())
router.post('/uploads/delete', uploadDelete)

async function uploadDelete(req, res) {
	allowAcessControl(res)
	req.body.qquuid
	// res.json(await uploads.save(req))
}

module.exports = router