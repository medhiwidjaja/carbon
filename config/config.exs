import Config

config :carbon,
  ecto_repos: [Carbon.Repo]

config :carbon, Carbon.Repo,
  database: "carbon_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
