
GapiDb - Class for database connection.

    sparqljs = require('sparqljs')
    self = null

    class GapiDb

        constructor: (options) ->
            self = @
            @options = options or {}

    module.exports = GapiDb
