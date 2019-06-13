const express = require('express')
const app = express()
const routes  = require('./routes')
const path = require('path')

// set the home page route
app.get('/', function(req, res) {
	res.send('Eros Zé Gatão')
})

// view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'pug')

// Rotas
app.use('/', routes)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')))

module.exports = app