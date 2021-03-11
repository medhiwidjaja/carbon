defmodule Carbon.FetcherTest do
  use ExUnit.Case, async: true

  setup do
    :ets.new(:carbon, [:named_table, :public])
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "start/0" do
    test "fetch data for indicated date and time", %{bypass: bypass} do
      Bypass.expect bypass, fn conn ->
        Plug.Conn.resp(conn, 200, payload())
      end

      response = Carbon.Fetcher.start("http://localhost:#{bypass.port}/")

      assert {:ok, pid} = response
      assert [{pid, payload()}] == :ets.lookup :carbon, pid
    end

    test "client can recover from server downtime", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, "")
      end)

      {:ok, client} = Carbon.Fetcher.start("http://localhost:#{bypass.port}/")

      assert {:ok, _} = Carbon.Fetcher.start("http://localhost:#{bypass.port}/")

      # Blocks until the TCP socket is closed.
      Bypass.down(bypass)

      assert {:error, :econnrefused} == Carbon.Fetcher.start("http://localhost:#{bypass.port}/")

      Bypass.up(bypass)

      assert {:ok, _} = Carbon.Fetcher.start("http://localhost:#{bypass.port}/")
    end
  end

  defp payload do
    ~s({
        "data":[{
          "from": "2021-03-11T05:00Z",
          "to": "2021-03-11T05:30Z",
          "intensity": {
            "forecast": 98,
            "actual": 97,
            "index": "low"
          }
        }]
      })
  end
end
