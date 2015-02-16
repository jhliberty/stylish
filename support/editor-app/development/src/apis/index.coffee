class Api
  constructor: (options={})->
    @base = options.base
    @host = options.host

  get: (endpoint)->
    $.get("http://localhost:8080/stylish/#{endpoint}")

  browsePackages: ->
    @get("models/browse/packages")

  showPackage:(slug)->
    @get("models/show/packages/#{slug}")

module.exports = apis = {}

apis.stylish = new Api()
