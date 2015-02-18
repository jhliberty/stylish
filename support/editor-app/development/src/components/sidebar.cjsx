register "Sidebar"

helpers
  mixins: [Router.State]

properties
  launch: ".ui.launch.button"
  element: ".ui.sidebar"

events
  componentDidMount: ->
    console.log "Sidebar Mounted"
    $(@props.element).sidebar()
    $(@props.launch).on "click", => $(@props.element).sidebar('toggle')

view ->
  <div className="ui inverted vertical menu">
    <a href="#" className="item">
      <i className="home icon"></i>
      Home
    </a>
  </div>

module.exports = finished()
