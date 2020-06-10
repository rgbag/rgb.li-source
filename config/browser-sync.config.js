// Enable HTTPS for snippet mode
module.exports = {
    // https: true,
    https: {
        key: "/Users/sebastian/HTTPS/localhost+1-key.pem",
        cert: "/Users/sebastian/HTTPS/localhost+1.pem"
    },
    startPath: "",
    callbacks: {
        /**
         * This 'ready' callback can be used
         * to access the Browsersync instance
         */
        ready: function(err, bs) {

            // example of accessing URLS
            console.log(bs.options.get('urls'));

            // example of adding a middleware at the end
            // of the stack after Browsersync is running
            bs.addMiddleware("*", function (req, res) {
                res.writeHead(302, {
                    location: "404.html"
                });
                res.end("Redirecting!");
            });
        }
    }
};


