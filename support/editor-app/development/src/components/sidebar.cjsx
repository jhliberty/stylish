module.exports = 
  displayName: "Sidebar"
  
  getDefaultProps: ->
    launchSelector: ".ui.launch.button"
    sidebarSelector: ".ui.sidebar"

  componentDidMount: ->
    $(@props.sidebarSelector).sidebar()
    $(@props.launchSelector).on "click", => $(@props.selector).sidebar('toggle')

  render: ->
    <div className="ui inverted vertical menu">
      <a href="#" className="item">
        <i className="home icon"></i>
        Home
      </a>
    </div>
