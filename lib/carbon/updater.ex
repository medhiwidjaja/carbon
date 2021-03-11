defmodule Carbon.Updater do
  use GenServer
  require Logger

  @me __MODULE__
  @table :carbon

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: @me)
  end

  def fetch_update() do
    task = Task.async(&Carbon.Fetcher.start/0)
    {:ok, _pid} = Task.await task
  end

  ## Server Callbacks

  def init(%{}) do
    :ets.new(@table, [:named_table, :public])
    {:ok, %{}}
  end

  ## Helper Functions


end
