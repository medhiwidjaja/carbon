defmodule Carbon.IntensityTest do
  use ExUnit.Case

  alias Carbon.Measure.Intensity

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Carbon.Repo)
  end

  test "changeset is ok for valid data" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: DateTime.utc_now(),
        to_time: DateTime.utc_now(),
        actual: 111,
        forecast: 123,
        index: "moderate"
      })

    assert changeset.valid?
  end

  test "changeset is invalid if 'from' is missing" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: nil,
        to_time: DateTime.utc_now(),
        actual: 111,
        forecast: 123,
        index: "moderate"
      })

    refute changeset.valid?
  end

  test "changeset is invalid if 'to' is missing" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: DateTime.utc_now(),
        to_time: nil,
        actual: 111,
        forecast: 123,
        index: "moderate"
      })

    refute changeset.valid?
  end

  test "changeset is invalid if 'actual' is missing" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: DateTime.utc_now(),
        to_time: DateTime.utc_now(),
        actual: nil,
        forecast: 123,
        index: "moderate"
      })

    refute changeset.valid?
  end

  test "changeset is invalid if 'index' is missing" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: DateTime.utc_now(),
        to_time: DateTime.utc_now(),
        actual: 111,
        forecast: 123,
        index: nil
      })

    refute changeset.valid?
  end

  test "changeset is invalid if 'forecast' is missing" do
    changeset =
      Intensity.changeset(%Intensity{}, %{
        from_time: DateTime.utc_now(),
        to_time: DateTime.utc_now(),
        actual: 111,
        forecast: nil,
        index: "moderate"
      })

    refute changeset.valid?
  end

  test "changeset is invalid for duplicate data" do
    t1 = ~U[2021-03-11 15:00:00Z]
    t2 = ~U[2021-03-11 15:30:00Z]
    Carbon.Repo.insert(%Intensity{from_time: t1, to_time: t2, actual: 555})
    changeset = Intensity.changeset(%Intensity{}, %{from_time: t1, to_time: t2, actual: 555})
    {:error, cs} = Carbon.Repo.insert(changeset)
    refute cs.valid?
  end
end
