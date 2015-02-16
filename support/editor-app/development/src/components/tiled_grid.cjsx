c = register "TiledGrid"

properties
  perRow: 4

helpers
  applyFormatter: (listOfChunks)->
    formatter = @props.formatter
    itemClass = @props.itemClass
    
    buildColumn = (item, index)->
      <div className="ui column #{itemClass}" key="column-#{index}">
        {formatter(item)}
      </div>

    html = _(listOfChunks).map (group, index)->
      <div className="ui row" key="row-#{index}">
        {_(group).map(buildColumn)}
      </div>

    html

view ->
  cx = React.addons.classSet

  classes = 
    "ui tiled grid": true
  
  classes["#{ util.wordsForNumber(@props.perRow) } columns"] = true

  <div className={cx(classes)}>
    {@applyFormatter(util.chunk(@props.items, @props.perRow))}
  </div>

module.exports = c.register()
