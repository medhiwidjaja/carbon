defmodule Carbon.Processor do

  alias Carbon.Intensity

  @table :carbon

  def start(key) when is_nil(key), do: {:error, "Key is nil"}
  def start(key) do
    :ets.lookup(@table, key)
    |> case do
      [] -> {:error, key, "Data not found"}
      [{^key, json}] -> process(key, json)
    end
  end

  defp process(key, json) do
    json
    |> parse()
    |> Enum.map(fn row ->
         Intensity.changeset(%Intensity{}, row)
       end)
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn ({changeset, index}, multi) ->
          Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
       end)
    |> Carbon.Repo.transaction
    |> case do
      {:ok, result} ->
        :ets.delete @table, key
        {:ok, result}
      {:error, _, %{errors: [from_time: {"has already been taken", _}]}, _} ->
        {:error, key, "Duplicate data"}
      _ ->
        {:error, :unknown}
    end
  end

  defp parse(json) do
    json
    |> Jason.decode!
    |> Map.get("data")
    |> Enum.map(fn data ->
        from   = data["from"] |> normalize_date()
        to     = data["to"]   |> normalize_date()
        actual = data["intensity"]["actual"]
        %{from_time: from, to_time: to, actual: actual}
    end)
  end

  defp normalize_date(datestring),
    do: String.replace_trailing(datestring, "Z", ":00Z")

end
