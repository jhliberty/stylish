stylish = require("../apis/index").stylish

TiledGrid = require("../components/tiled_grid")
Link = require("react-router").Link

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
      <Link to="package_details" params={slug: pkg.slug}>
        {pkg.name}
      </Link>
    </div>

  render: ->
    <div className="ui body">
      <div className="ui header">
        <h4>Stylish Packages</h4>
      </div>

      <TiledGrid perRow=4 
                 items={@state.packages} 
                 formatter={@showPackage} 
                 itemClass="stylish-package" />
    </div>

  statics:
    willTransitionTo: ->
      $('.ui.sidebar').sidebar('hide')
