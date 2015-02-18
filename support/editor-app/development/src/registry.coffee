module.exports = iface = {}

global            = if typeof(window) isnt "undefined" then window else global

registry = {pages:{}, apis: {}, components: {}}

iface.loaded = ->
  _.extend(registry.apis, require("./apis"))
  _.extend(registry.pages, require("./pages"))
  _.extend(registry.components, require("./components"))
  iface

iface.setPage = (name, componentClass)->
  registry.pages[name] = componentClass

iface.setComponent = (name, componentClass)->
  registry.component[name] = componentClass

iface.setApi = (name, component)->
  registry.apis[name] = component

iface.getPage = (identifier)->
  registry.pages[identifier]

iface.getComponent = (identifier)->
  registry.components[identifier]

iface.getApi = (identifier)->
  registry.apis[identifier]

iface.globalized = ->
  for prop, val of iface
    global[prop] = iface[val]

  iface
