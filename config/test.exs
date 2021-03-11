use Mix.Config

config :carbon, Carbon.Repo,
  username: "postgres",
  password: "postgres",
  database: "carbon_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
