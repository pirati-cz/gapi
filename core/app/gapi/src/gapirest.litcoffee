
GapiRest - GAPI class for REST.

    restify = require('restify')
    rdfstore = require('rdfstore')
    self = null

    class GapiRest

        constructor: (options) ->
            self = @
            @options = options or {}
            if not @options.formatters
                @options.formatters = {}
                @options.formatters['application/json; q=0.9'] = @formatJSON
                @options.listenPort ?= 8008
                if @options.ssl
                    if @options.sslKeyFile and @options.sslCertificateFile
                        fs = require('fs')
                        @options.certificate = fs.readFileSync(@options.sslCertificateFile)
                        @options.key = fs.readFileSync(@options.sslKeyFile)
                    else
                        console.warn('SSL option requires you to specify sslKey and sslCert. Starting without SSL.')
            server = restify.createServer(@options)
            server.listen(@options.listenPort, () ->
                console.log('%s listening at %s', server.name, server.url)
            )
            @server = server

        @run: (argv, exit) ->
            gapirest = new GapiRest()
            #gapirest.initLocalApps()
            #gapirest.initApps()

        formatJSON: (req, res, body) ->
            if body instanceof Error
                res.statusCode = body.statusCode || 500
                if body.body
                    body = body.body
                else
                    body = message: body.message
            else
                if (Buffer.isBuffer(body))
                    body = body.toString('base64')
            data = JSON.stringify(body, null, '  ')
            res.setHeader('Content-Length', Buffer.byteLength(data))
            data


    module.exports = GapiRest

