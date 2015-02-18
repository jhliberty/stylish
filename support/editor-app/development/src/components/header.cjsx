register "Header"

properties
  title: "Stylish.io"
  tag: "h4"

view ->
  <div className="ui page header">
    {React.createElement(@props.tag, {}, @props.title)}
  </div>

module.exports = finished()
