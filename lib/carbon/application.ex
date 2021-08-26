defmodule Carbon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Carbon.Repo,
      # Start the Telemetry supervisor
      CarbonWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Carbon.PubSub},
      # Start the Endpoint (http/https)
      CarbonWeb.Endpoint,
      # Start a worker by calling: Carbon.Worker.start_link(arg)
      # {Carbon.Worker, arg}
      {Carbon.Updater, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Carbon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CarbonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
