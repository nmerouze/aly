const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: [
    './web/static/scss/app.scss',
    './web/static/js/app.js',
  ],
  output: {
    path: path.resolve(__dirname, 'priv/static'),
    filename: 'js/app.js'
  },
  module: {
    loaders: [{
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract('style', 'css!autoprefixer!sass'),
      include: path.resolve(__dirname, 'web/static/scss'),
    }, {
      test: /\.elm$/,
      include: path.resolve(__dirname, 'web/static/elm'),
      loader: 'elm-webpack'
    }],
    noParse: /\.elm$/,
  },
  plugins: [
    new ExtractTextPlugin('css/app.css'),
  ],
};
