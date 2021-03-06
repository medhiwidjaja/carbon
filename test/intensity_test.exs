defmodule Carbon.IntensityTest do
  use ExUnit.Case

  alias Carbon.Intensity

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Carbon.Repo)
  end

  test "changeset is ok for valid data" do
    changeset = Intensity.changeset(%Intensity{}, %{from_time: DateTime.utc_now, to_time: DateTime.utc_now, actual: 555})
    assert changeset.valid?
  end

  test "changeset is invalid if 'from' is missing" do
    changeset = Intensity.changeset(%Intensity{}, %{from_time: nil, to_time: DateTime.utc_now, actual: 555})
    refute changeset.valid?
  end

  test "changeset is invalid if 'to' is missing" do
    changeset = Intensity.changeset(%Intensity{}, %{from_time: DateTime.utc_now, to_time: nil, actual: 555})
    refute changeset.valid?
  end

  test "changeset is invalid if 'actual' is missing" do
    changeset = Intensity.changeset(%Intensity{}, %{from_time: DateTime.utc_now, to_time: DateTime.utc_now, actual: nil})
    refute changeset.valid?
  end

  test "changeset is invalid for duplicate data" do
    t1 = ~U[2021-03-11 15:00:00Z]
    t2 = ~U[2021-03-11 15:30:00Z]
    Carbon.Repo.insert %Intensity{from_time: t1, to_time: t2, actual: 555}
    changeset = Intensity.changeset(%Intensity{}, %{from_time: t1, to_time: t2, actual: 555})
    {:error, cs} = Carbon.Repo.insert changeset
    refute cs.valid?
  end

  test "get latest record from database" do
    t1 = ~U[2021-03-11 22:00:00Z]
    t2 = ~U[2021-03-11 22:30:00Z]
    Carbon.Repo.insert %Intensity{from_time: t1, to_time: t2, actual: 333}

    latest = Intensity.get_latest()
    assert latest.actual == 333
    assert latest.to_time == t2
  end


end
