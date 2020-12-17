const path = require('path');

module.exports = {
  entry: './node_src/index.jsx',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist/gtc/'),
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        include: [
          path.resolve(__dirname, "node_src")
        ],
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      }
    ]
  }
};