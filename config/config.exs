import Config

config :carbon,
  ecto_repos: [Carbon.Repo]

config :carbon, Carbon.Repo,
  database: "carbon_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :carbon,
  urlbase: "https://api.carbonintensity.org.uk/intensity"
