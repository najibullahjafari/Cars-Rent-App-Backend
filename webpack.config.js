const path = require('path');

module.exports = {
  entry: './app/javascript/packs/application.js', // Adjust this path based on your project structure
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public', 'packs'),
  },
  // Add other configurations as needed
};
