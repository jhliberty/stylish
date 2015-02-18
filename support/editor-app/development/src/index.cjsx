require "./styles/index.css.scss"
require "codemirror/lib/codemirror.css"

$                 = require "jquery"
_                 = require "underscore"
global            = if typeof(window) isnt "undefined" then window else global

React           = require("expose?React!react/addons")
global.Router   = require "react-router-component"

Locations       = Router.Locations
Location        = Router.Location

global.util       = require "./lib/util"
global.stylish    = require("./apis").stylish

global.factory    = React.createFactory
global.Link       = Router.Link

definitions       = require("./sugar").globalized()
registry          = require("./registry").globalized().loaded()

{getComponent, getPage} = registry

HomePage            = getPage("HomePage")
PackageDetailsPage  = getPage("PackageDetailsPage")
Sidebar             = getComponent("Sidebar")

Application = React.createClass
  displayName: "Application"
  
  getInitialState: ->
    loaded: false
    fullWidth: false

  getContainerClasses: ->
    cx
      "full": true
      "height": true
      "container": !@requiresFullWidth()

  requiresFullWidth: ->
    @state.fullWidth is true

  componentDidMount: ->
    @setState(loaded: true)
    @sidebar = React.render(<Sidebar />, el("sidebar"))
    @setWidth()

  onNavigation: ->
    @setWidth()
    $('#sidebar').sidebar('hide')
  
  setWidth: ->
    route = @getCurrentRoute()

    if route && route.props.fullWidth?
      @setState(fullWidth: route.props.fullWidth)

  getSidebar: ->
    @sidebar

  getCurrentRoute: ->
    _(@refs.router?.refs).values()[0]
  
  isLoaded: ->
    @state.loaded is true

  render: ->
    if @isLoaded() then @showApp() else @showLoadingIndicator()

  showLoadingIndicator: ->
    <div className="ui alert">Loading</div>

  showApp: ->
    <Locations ref="router" className={@getContainerClasses()} onNavigation={@onNavigation} onBeforeNavigation={@onBeforeNavigation} hash=true>
      <Location ref="package_details" path="/packages/:slug" handler={PackageDetailsPage} />
      <Location ref="home_page" path="/" handler={HomePage} />
    </Locations>

$ ->
  global.App = React.render(<Application />, document.getElementById('app')) 
