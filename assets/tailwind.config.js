const colors = require('tailwindcss/colors')

module.exports = {
  purge: {
    enabled: process.env.NODE_ENV === "production",
    content: [
      "../lib/**/*.eex",
      "../lib/**/*.leex",
      "../lib/**/*_view.ex",
      './js/**/*.js'
    ],
    options: {
      whitelist: [/phx/, /nprogress/]
    }
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      sans: ['Nunito', 'sans-serif'],
      serif: ['Merriweather', 'serif'],
    },
    extend: {
      spacing: {
        '128': '32rem',
        '144': '36rem',
      },
      borderRadius: {
        '4xl': '2rem',
      }
    }
  },
  variants: {
    extend: {
      borderColor: ['focus-visible'],
      opacity: ['disabled'],
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
