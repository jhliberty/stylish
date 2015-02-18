module.exports = sugar = {}

registry = require("./registry")

class ComponentDefinition
  constructor: (name, options={})->
    @name = name
    @completed = false
    @type = options.type || "component"
    @mixins = options.mixins if options.mixins?.length > 0

    global.previousComponent = @

  state: (initialState)->
    @initialState = initialState
    @
  
  properties: (defaultProperties)->
    @defaultProperties = defaultProperties
    @
  
  view: (v)->
    @_view = v
    @
  
  helpers: (helpers={})->
    @helpers ||= {}
    @helpers = _.extend(@helpers, helpers)
    @

  classMethods: (classMethods={})->
    @classMethods ||= {}
    @classMethods = _.extend(@classMethods, classMethods)
    @

  events: (helpers={})->
    @helpers ||= {}
    @helpers = _.extend(@helpers, helpers)
    @
  
  finished: (cb)->
    @register(cb)

  register: (cb)->
    @completed = true
    
    definition = _.extend @helpers || {},
      displayName: @name
      render: @_view || (->)
   
    if @classMethods
      definition.statics = _.extend((definition.statics || {}), @classMethods) 
    
    if @mixins?.length > 0
      definition.mixins = @mixins

    me = @
    
    if _.isFunction(@defaultProperties)
      definition.getDefaultProps = @defaultProperties
    else if _.isObject(@defaultProperties)
      definition.getDefaultProps = ->
        me.defaultProperties
    
    if _.isFunction(@initialState)
      definition.getInitialState = @initialState

    else if _.isObject(@initialState)
      definition.getInitialState = -> 
        me.initialState
    
    if _.isArray(@mixins) and @mixins.length > 0
      definition.mixins = @mixins

    k = React.createClass(definition)
    cb?(k)
    
    if @type is "component"
      global.setComponent?(@name, k)

    if @type is "page"
      global.setPage?(@name, k)

    global.previousComponent = undefined
    k

global.previousComponent = undefined

# implement a poor man's method missing for certain functions that get used
# during the react component definition stage
originals = {}

delegate = (fnName)->
  sugar[fnName] = ->
    global.previousComponent?[fnName]?.apply(global.previousComponent, arguments)

for fn in ['properties', 'helpers', 'events', 'view', 'state', 'classMethods', 'finished']
  originals[fn] = global[fn]
  delegate(fn) 

global.register = (name, options={})-> 
  global.previousComponent = new ComponentDefinition(name, options)

global.page = (name, options={})->
  #options.mixins ||= []
  #options.mixins.push(Router.State)
  global.previousComponent = new ComponentDefinition(name, options)

global.component = (name, options={})->
  options.type = "component"
  global.previousComponent = new ComponentDefinition(name, options)

global.el = (id)-> document.getElementById(id)
global.cx = React.addons.classSet

# makes the sugar available to all the scripts
sugar.globalized = ->
  for prop, val of originals
    global[prop] = sugar[prop]

  sugar

# cleans up after the sugar
sugar.finish = ->
  for prop, val of originals
    global[prop] = val
