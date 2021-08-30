defmodule CarbonWeb.ChartLive.Index do
  use CarbonWeb, :live_view

  alias Contex.{Dataset, Plot, LinePlot}
  alias Carbon.Measure

  def mount(_session, socket) do
    {:ok, assign(socket, conn: socket)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    entries = Measure.list_intensities()

    {:noreply, assign(socket, entries: entries)}
  end

  def create_chart(entries) do
    entries
    |> Enum.map(fn e -> {e.from_time, e.actual} end)
    |> Dataset.new(["x", "y"])
    |> Plot.new(LinePlot, 600, 400, [])
    |> Plot.titles("Carbon Intensity", "")
    |> Plot.to_svg()
  end
end
