require "./styles/index.css.scss"
require "codemirror/lib/codemirror.css"

$                 = require "jquery"
_                 = require "underscore"

React         = require("expose?React!react/addons")
Router        = require "react-router"

Route         = Router.Route
DefaultRoute  = Router.DefaultRoute
RouteHandler  = Router.RouteHandler
Link          = Router.Link

{Route, DefaultRoute, RouteHandler, Link} = Router

global            = if typeof(window) isnt "undefined" then window else global
global.util       = require "./lib/util"
sugar             = require("./sugar").globalized()
global.stylish    = require("./apis").stylish

Application = require("./lib/app")

Application.create("App", name: "Stylish App", -> sugar.finish())
