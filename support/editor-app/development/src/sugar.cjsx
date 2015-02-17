module.exports = sugar = {}

components = {}

global            = window if typeof(window) isnt "undefined"

class ComponentDefinition
  constructor: (name)->
    @name = name
    @completed = false

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

  events: (helpers={})->
    @helpers ||= {}
    @helpers = _.extend(@helpers, helpers)
    @

  register: (cb)->
    @completed = true
    
    definition = _.extend @helpers || {},
      displayName: @name
      render: @_view || (->)
    
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
    
    k = React.createClass(definition)
    cb?(k)

    global.lastComponent = undefined
    k

global.lastComponent = undefined

sugar.register = (name, options={})-> 
  global.lastComponent = new ComponentDefinition(name, options={})

sugar.properties = -> global.lastComponent.properties.apply(lastComponent, arguments)
sugar.helpers = -> global.lastComponent.helpers.apply(lastComponent, arguments)
sugar.events = -> global.lastComponent.events.apply(lastComponent, arguments)
sugar.view = -> global.lastComponent.view.apply(lastComponent, arguments)
sugar.state = -> global.lastComponent.state.apply(lastComponent, arguments)

originals = 
  properties: global.properties
  events: global.events
  helpers: global.helpers
  view: global.view
  state: global.state
  register: global.register

sugar.globalized = ->
  global.properties = sugar.properties
  global.view = sugar.view
  global.state = sugar.state
  global.register = sugar.register
  global.helpers = sugar.helpers
  global.events = sugar.events
  sugar

sugar.finish = ->
  for prop, val of originals
    global[prop] = val
