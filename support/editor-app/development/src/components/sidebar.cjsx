module.exports = React.createClass
  displayName: "Sidebar"
  
  getDefaultProps: ->
    launch: ".ui.launch.button"
    element: ".ui.sidebar"

  componentDidMount: ->
    $(@props.element).sidebar()
    $(@props.launch).on "click", => $(@props.element).sidebar('toggle')

  render: ->
    <div className="ui inverted vertical menu">
      <a href="#" className="item">
        <i className="home icon"></i>
        Home
      </a>
    </div>
