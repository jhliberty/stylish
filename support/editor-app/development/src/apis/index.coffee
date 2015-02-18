class Api
  constructor: (options={})->
    @base = options.base
    @host = options.host
    @cache = {}

  get: (endpoint)->
    $.get("http://localhost:8080/stylish/#{endpoint}")

  browsePackages: (cb)->
    packages = @cache.packages

    if packages
      cb(packages)
      return

    @get("models/browse/packages").then (r)=>
      @cache.packages = r
      cb(r)

  showPackage:(slug, cb)->
    @cache.packageDetails ||= {}
    existing = @cache.packageDetails[slug]

    if existing
      cb(existing)
      return
    else
      @get("models/show/packages/#{slug}").then (r)=>
        @cache.packageDetails[slug] = r
        cb(r)

module.exports = apis = {}

apis.stylish = new Api()
