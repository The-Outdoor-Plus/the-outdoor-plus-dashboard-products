module.exports = {
  client: {
    service: {
      name: 'the-outdoor-plus-products-dashboard',
      url: import.meta.env.VITE_MONDAY_API_URL || 'https://api.monday.com/v2',
    },
    includes: [
      'src/**/*.vue',
      'src/**/*.js',
      'src/**/*.ts',
    ],
  },
}
