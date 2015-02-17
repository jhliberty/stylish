React         = require("expose?React!react");
Router        = require "react-router"

Route         = Router.Route
DefaultRoute  = Router.DefaultRoute
RouteHandler  = Router.RouteHandler
Link          = Router.Link

{Route, DefaultRoute, RouteHandler, Link} = Router

Container = React.createClass
  displayName: "Container"

  render: ->
    <div className="full height">
      <div className="app container">
        <RouteHandler />
      </div>
    </div>

registry = {}

registry.components = require("../components/index")
registry.pages      = require("../pages/index")
registry.apis       = require("../apis/index")

module.exports = class Application
  component: (identifier)->
    registry.components[identifier]

  page: (identifier)->
    registry.pages[identifier]

  apis:
    stylish: registry.apis.stylish

Application.create = (identifier, options={}, cb=(->))->
  app = window[identifier] = new Application(options)
  
  Sidebar             = app.component("Sidebar")
  HomePage            = app.page("HomePage") 
  PackageDetailsPage  = app.page("PackageDetailsPage")
  
  routes = (
    <Route handler={Container}>
      <DefaultRoute name="index" handler={HomePage} />
      <Route name="package_details" path="/packages/:slug" handler={PackageDetailsPage} />
    </Route>
  )
  
  el = (id)-> document.getElementById(id)

  Router.run routes, (Handler)->
    React.render(<Sidebar element=".ui.sidebar" launch=".ui.launch.button" />, el("sidebar"))
    React.render(<Handler/>, el("app"))
    cb()
