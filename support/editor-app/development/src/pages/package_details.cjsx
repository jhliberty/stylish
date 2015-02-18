page "PackageDetailsPage"

state
  loaded: false
  package: undefined

properties
  fullWidth: false

events
  componentDidMount: ->
    @fetchStateFromApi() unless @isLoaded()
  
  fetchStateFromApi: ->
    page = @
    slug = @props.slug 
    
    if slug? && _.isUndefined(@state.package)
      stylish.showPackage slug, (pkg)->
        page.setState(package: pkg, loaded: true)

helpers 
  isLoaded: ->
    @state.loaded is true

  getBody: ->
    if @isLoaded() then @showDetails() else @loadingIndicator()
  
  loadingIndicator: ->
    <div className="ui loading indicator">Loading...</div>

  showDetails: ->
    pkg = @state.package

    <div className="ui package details">
      <div className="ui header">
        <h4>{pkg.name}</h4>
        <pre>
          <code>
            {JSON.stringify(pkg)}
          </code>
        </pre>
      </div>
    </div>

view -> 
  <div className="ui page package-details">
    {@getBody()}  
  </div>

module.exports = finished() 
