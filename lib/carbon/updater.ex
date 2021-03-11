defmodule Carbon.Updater do
  use GenServer
  require Logger

  @me __MODULE__
  @table :carbon
  @urlbase Application.get_env(:carbon, :urlbase)

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: @me)
  end

  def fetch_update() do
    task = Task.async(fn -> Carbon.Fetcher.start(@urlbase) end)
    {:ok, _pid} = Task.await task
  end

  ## Server Callbacks

  def init(%{}) do
    :ets.new(@table, [:named_table, :public])
    {:ok, %{}}
  end

  ## Helper Functions


end
