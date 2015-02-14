/**
 * @see http://webpack.github.io/docs/configuration.html
 * for webpack configuration options
 */
var webpack = require("webpack");

module.exports = {
  context: __dirname,

  entry: {
    toolkit: "./src/index.cjsx"
  },

  output: {
    path: __dirname + "/../dist",
    filename: "[name].js",
    library: ["Architects","[name]"],
    libraryTarget: "umd",
  },

  resolve: {
    extensions: ["",".js",".coffee",".cjsx",".scss",".html"],
    modulesDirectories: [
      'node_modules', 
      'bower_components'
    ],
  },

  plugins: [
    new webpack.ProvidePlugin({
      "_": "underscore",
      "Backbone": "backbone"
    }) 
  ],

  externals:{
    "jquery": "var jQuery",
    "$"     : "var jQuery"
  },

  // The 'module' and 'loaders' options tell webpack to use loaders.
  // @see http://webpack.github.io/docs/using-loaders.html
  module: {
    loaders: [
      { test: /\.coffee$/, loaders: ["coffee-loader"] },
      { test: /\.cjsx$/, loaders: ["coffee-loader","cjsx-loader"] },
      { test: /\.scss$/, loader: "style!css!sass?outputStyle=expanded"},
      { test: /\.css$/, loader: "style!css!sass?outputStyle=expanded"},
      {test: /\.(jpg|png|gif|svg)/, loader: 'file-loader?path=smooth-developer-tools'},
      {test: /\.(eot|ttf|woff)/, loader: 'file-loader?path=smooth-developer-tools'}
    ]
  }
};
