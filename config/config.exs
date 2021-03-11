import Config

config :carbon,
  ecto_repos: [Carbon.Repo]

config :carbon,
  urlbase: "https://api.carbonintensity.org.uk/intensity"


import_config "#{Mix.env()}.exs"
