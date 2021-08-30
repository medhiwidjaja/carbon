defmodule CarbonWeb.PageLive do
  use CarbonWeb, :live_view

  alias Carbon.Measure

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, uri, params)}
  end

  defp apply_action(socket, :index, uri, _params) do
    current = Measure.get_latest()

    socket
    |> assign(:conn, socket)
    |> assign(:current, current)
    |> assign(uri: URI.parse(uri))
  end
end
