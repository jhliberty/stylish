stylish = require("../apis/index").stylish

TiledGrid = require("../components/tiled_grid")

module.exports = React.createClass 
  displayName: "HomePage"
  
  getInitialState: ->
    packages: []
  
  componentDidMount: ->
    page = @
    stylish.browsePackages().then (response)->
      page.setState(packages: response)

  showPackage: (pkg)->
    <div className="ui card" key={pkg.slug}>
      {pkg.name}
    </div>

  render: ->
    <div className="ui body">
      <div className="ui header">
        <h4>Stylish Packages</h4>
      </div>

      <TiledGrid perRow=4 items={@state.packages} formatter={@showPackage} itemClass="stylish-package"/>
    </div>

  statics:
    willTransitionTo: ->
      $('.ui.sidebar').sidebar('hide')
