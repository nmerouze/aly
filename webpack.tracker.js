const path = require("path");
const webpack = require("webpack");

module.exports = {
  devtool: "cheap-module-eval-source-map",
  entry: "./tracker/src/index.ts",
  output: {
    path: path.resolve(__dirname, "./priv/static/js"),
    filename: "aly.js",
  },
  resolve: {
    extensions: ["", ".webpack.js", ".ts", ".js"],
  },
  module: {
    loaders: [
      { test: /\.tsx?$/, loader: "ts-loader" }
    ],

    preLoaders: [
      { test: /\.js$/, loader: "source-map-loader" }
    ]
  },
};
