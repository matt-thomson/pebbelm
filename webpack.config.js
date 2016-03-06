var webpack = require( 'webpack' );

module.exports = {
  entry: './src/index.js',
  output: {
    path: './dist',
    filename: 'app.js',
    libraryTarget: "umd"
  },
  resolve: {
    modulesDirectories: ['node_modules'],
    extensions:         ['', '.js', '.elm']
  },
  module: {
    loaders: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack'
      }
    ],
    noParse: /\.elm$/
  },
  externals: ["ui"],
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      minimize:   true,
      compressor: { warnings: false },
      mangle:     true
    })
  ]
}
