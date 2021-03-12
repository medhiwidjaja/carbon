import Config

config :carbon,
  ecto_repos: [Carbon.Repo]

config :carbon,
  urlbase: "https://api.carbonintensity.org.uk/intensity",
  update_delay: 10,  # Number of minutes to wait for the half-hour download to start
  starting_datetime: "2021-03-01T05:00:00Z"   # Starting date/time to fill in the database

  import_config "#{Mix.env()}.exs"
