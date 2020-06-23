module.exports = {
	content: ['source/index.html', 'source/js/*.js'],
	css: ['source/css/*.css'],
	keyframes: true,
	fontFace: true,
	extractors: [
	  {
		extractor: class {
		  static extract(content) {
			return content.match(/[A-z0-9-:\/]+/g) || []
		  }
		},
		extensions: ['html', 'pug']
	  }
	]
  }