stylish = require("../apis/index").stylish

TiledGrid = require("../components/tiled_grid")

page "HomePage"

helpers
  showPackage: (pkg)->
    <div className="ui card" key={pkg.slug}>
      <Link href="/packages/#{ pkg.slug }">{pkg.name}</Link>
    </div>

state
  loaded: false
  packages: []

properties
  fullWidth: false

helpers
  isLoaded: -> 
    @state.loaded is true

events
  componentDidMount: ->
    @fetchStateFromApi() unless @isLoaded()

  fetchStateFromApi: ->
    page = @

    stylish.browsePackages (response)->
      page.setState(packages: response, loaded: true)

view ->
  <div className="ui body">
    <div className="ui header">
      <h4>Stylish Packages</h4>
    </div>

    <TiledGrid perRow=4 
               items={@state.packages} 
               formatter={@showPackage} 
               itemClass="stylish-package" />
  </div>

module.exports = finished()
