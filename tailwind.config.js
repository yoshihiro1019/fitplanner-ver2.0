module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/javascripts/**/*.js',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        'red-200': '#FECACA', // 明るい赤
        'red-400': '#FCA5A5', // 少し濃い赤
        'red-600': '#DC2626', // 中程度の赤
        'red-800': '#9B1C1C', // 濃い赤
      },
      fontFamily: {
        emoji: ['system-ui', '-apple-system', 'Segoe UI Emoji', 'Apple Color Emoji', 'Noto Color Emoji', 'sans-serif'],
      },
    },
  },
  plugins: [],
};
