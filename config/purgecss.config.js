module.exports = {
	content: ['source/index.pug', 'source/src/index/*.pug', 'source/js/*.js'],
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