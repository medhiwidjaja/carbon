defmodule CarbonWeb.PageLive do
  use CarbonWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    list = Carbon.Intensity.get_list()

    socket
    |> assign(:table, list)
  end
end
