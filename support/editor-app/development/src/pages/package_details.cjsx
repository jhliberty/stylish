Router = require("react-router")

c = register "PackageDetailsPage"

state ->
  loading: true
  package: undefined

events
  componentDidMount: ->
    page = @
    
    if @isLoading()
      stylish.showPackage(@getParams().slug).then (pkg)->
        page.setState(package: pkg, loading: false)

helpers 
  mixins: [Router.State]

  isLoading: ->
    @state.loading is true

  getBody: ->
    if @isLoading() then @loadingIndicator() else @showDetails()
  
  loadingIndicator: ->
    <div className="ui loading indicator">Loading...</div>

  showDetails: ->
    pkg = @state.package

    <div className="ui package details">
      <div className="ui header">
        <h4>{pkg.name}</h4>
      </div>
    </div>

view -> 
  <div className="ui page package-details">
    {@getBody()}  
  </div>

module.exports = c.register()
