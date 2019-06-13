const db = require('../helpers/dbConnector')
// https://github.com/felixge/node-formidable
const formidable = require('formidable')

let files = {}
let params = {}
let fileFields = []

module.exports = {
	save: (req, res) => {
		return new Promise((resolve, reject) => {
			let form = new formidable.IncomingForm()
			form.uploadDir = "./uploads"
			form.multiples = true
			form.keepExtensions = true

			form.on('field', function(field, value) {
				params[field] = value
			})

			form.on('file', function(field, file) {
				if(!fileFields.includes(field)) {
					fileFields.push(field)
				}

				if(!files[field]) {
					files[field] = []
				}
				
				files[field].push(file)
			})

			form.on('end', function() {
				let uploadedFiles = files[fileFields[0]]

				if(uploadedFiles.length == params.numFiles) {
					// Upload complete
					// the uploaded files
					resolve({ params: params, uploadedFiles: uploadedFiles })
					// Reset control vars
					files = {}
					params = {}
					fileFields = []
				}

				res.json({ success: true })
			})

			form.parse(req)
		})
	}
}