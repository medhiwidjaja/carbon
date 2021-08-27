defmodule Carbon.Updater do
  use GenServer
  require Logger

  alias Carbon.Measure

  @me __MODULE__
  @table :carbon
  @urlbase Application.get_env(:carbon, :urlbase)

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: @me)
  end

  ## Server Callbacks

  def init(%{}) do
    :ets.new(@table, [:named_table, :public])
    schedule_download()
    {:ok, %{}}
  end

  def handle_info(:download, state) do
    fetch_update()
    schedule_download()
    {:noreply, Map.put(state, :status, :downloading)}
  end

  def handle_info({:download, from, to}, state) do
    fetch_updates(from, to)
    schedule_download()
    {:noreply, Map.put(state, :status, :downloading)}
  end

  ## Helper Functions

  defp fetch_update() do
    fetcher = Task.async(fn -> Carbon.Fetcher.start(@urlbase) end)

    process(fetcher)
  end

  defp fetch_updates(from, to) do
    fetcher = Task.async(fn -> Carbon.Fetcher.start(@urlbase, from, to) end)

    process(fetcher)
  end

  defp process(fetcher) do
    {:ok, pid} = Task.await(fetcher)

    processor = Task.async(fn -> Carbon.Processor.start(pid) end)
    Task.await(processor)
  end

  defp schedule_download() do
    latest_record = Measure.get_latest()

    timestamp =
      case latest_record do
        nil ->
          Application.fetch_env!(:carbon, :starting_datetime)

        _ ->
          latest_record.to_time
          |> DateTime.add(Application.fetch_env!(:carbon, :update_delay) * 60)
          |> DateTime.to_iso8601()
      end

    schedule_work(timestamp)
    last_saved = if latest_record, do: latest_record.to_time |> DateTime.to_iso8601(), else: nil
    %{timestamp: timestamp, last_saved: last_saved, status: :scheduled}
  end

  defp schedule_work(start_time) do
    now = DateTime.utc_now()
    {:ok, ts, _} = DateTime.from_iso8601(start_time)

    if DateTime.diff(now, ts) / 60 < 30 do
      delay = 35 - rem(now.minute, 30)
      IO.puts("Update will be started in #{delay} minutes")
      Process.send_after(self(), :download, delay * 60 * 1000)
    else
      IO.puts("Update will start immediately")
      end_time = now |> DateTime.to_iso8601()
      Process.send(self(), {:download, start_time, end_time}, [:noconnect])
    end
  end
end
