defmodule Carbon.IntensityTest do
  use ExUnit.Case

  alias Carbon.Intensity

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
end
