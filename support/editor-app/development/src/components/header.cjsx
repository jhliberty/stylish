module.exports = React.createClass 
  displayName: "Header"

  getDefaultProps: ->
    title: "Stylish"

  render: ->
    <div className="ui page header">
      <h1>{@props.title}</h1>
    </div>
