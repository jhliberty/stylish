Link = require("react-router").Link
Editor = require "../components/editor"

module.exports = 
  displayName: "HomePage"

  render: ->
    <h1>what the fuck</h1>

  onEditorChange: ->

  statics:
    willTransitionTo: ->
      $('.ui.sidebar').sidebar('hide')
