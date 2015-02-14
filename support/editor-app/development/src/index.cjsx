require "./styles/index.css.scss"
require "codemirror/lib/codemirror.css"

$         = require "jquery"
_         =

React       = require("expose?React!react");
Router      = require "react-router"
Backbone    = require "backbone"; require "backbone-react-component"

{Route, DefaultRoute, RouteHandler, Link} = Router

# Load in the components
components  = require "./components/index"
pages       = require "./pages/index"
apis        = require "./apis/index"

Header      = React.createClass(components.Header)
Sidebar     = React.createClass(components.Sidebar)
HomePage    = React.createClass(pages.HomePage)

# Main App
App = React.createClass
  displayName: "App"
  
  render: ->
    <div className="full height">
      <div className="app container">
        <RouteHandler />
      </div>
    </div>

routes = (
  <Route handler={App}>
    <DefaultRoute name="index" handler={HomePage} />
  </Route>
)

Router.run routes, (Handler)->
  React.render(<Sidebar/>, document.getElementById('sidebar'))
  React.render(<Handler/>, document.getElementById('app'))
