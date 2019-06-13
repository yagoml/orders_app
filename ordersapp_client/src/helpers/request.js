function post(params) {
	let config = {
		method: 'post',
		mode: 'cors',
		headers: {
			'Content-Type': 'text/plain'
		}
	}

	if(params.data) {
		config.headers = {
			'Content-Type': 'application/json'
		}
		config.body = JSON.stringify(params.data)
	}

	fetch(params.route, config).then(res => {
		return res.json()
	}).then(res => {
		if(params.callback)
			params.callback(res)
	})
}

export default {
	post: post
}