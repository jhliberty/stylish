class Api
  constructor: (options={})->
    @base = options.base
    @host = options.host

  get: (endpoint)->
    $.get("http://topgrading.dev" + (@base || "/apis/architects") + "/#{ endpoint }")

module.exports = apis = {}

apis.architects = new Api(host: "http://topgrading.dev", base: "/apis/architects")
