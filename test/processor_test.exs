defmodule Carbon.FetcherTest do
  use ExUnit.Case

  setup do
    :ets.insert :carbon, {:key, data()}
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Carbon.Repo)
  end

  describe "start/1" do
    test "processing from :ets table" do
      {:ok, result} = Carbon.Processor.start :key
      assert map_size(result) > 0
      assert :ets.lookup(:carbon, :key) == []
    end
  end

  defp data() do
    "{ \r\n  \"data\":[{ \r\n    \"from\": \"2021-03-11T16:30Z\",\r\n    \"to\": \"2021-03-11T17:00Z\",\r\n    \"intensity\": {\r\n      \"forecast\": 130,\r\n      \"actual\": 132,\r\n      \"index\": \"low\"\r\n    }\r\n  }]\r\n}"
  end
end
