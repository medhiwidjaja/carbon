# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :carbon,
  ecto_repos: [Carbon.Repo]

# Configures the endpoint
config :carbon, CarbonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rqSFLx8Uiv+EzN+/VTyPoAbfmeQYae72vdlDl0exaUEE5PScFuqEShIXjwGCUfBK",
  render_errors: [view: CarbonWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Carbon.PubSub,
  live_view: [signing_salt: "0nY6U2bL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :carbon,
  urlbase: "https://api.carbonintensity.org.uk/intensity",
  # Number of minutes to wait for the half-hour download to start
  update_delay: 10,
  # Starting date/time to fill in the database
  starting_datetime: "2021-08-17T05:00:00Z"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
