module.exports = {
  content: [
    "./app/views/**/*.{html,erb}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  darkMode: "class",
  safelist: ["bg-gold", "bg-silver", "bg-bronze"],
  colors: {
    gold: "#FFD700",
    silver: "#C0C0C0",
    bronze: "#CD7F32",
  },
  theme: {
    extend: {},
  },
  plugins: [],
};
