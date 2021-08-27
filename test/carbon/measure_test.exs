defmodule Carbon.MeasureTest do
  use Carbon.DataCase

  alias Carbon.Measure

  describe "intensities" do
    alias Carbon.Measure.Intensity

    @valid_attrs %{
      actual: 42,
      forecast: 42,
      from_time: "2010-04-17T14:00:00Z",
      index: "some index",
      to_time: "2010-04-17T14:00:00Z"
    }
    @update_attrs %{
      actual: 43,
      forecast: 43,
      from_time: "2011-05-18T15:01:01Z",
      index: "some updated index",
      to_time: "2011-05-18T15:01:01Z"
    }
    @invalid_attrs %{actual: nil, forecast: nil, from_time: nil, index: nil, to_time: nil}

    def intensity_fixture(attrs \\ %{}) do
      {:ok, intensity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Measure.create_intensity()

      intensity
    end

    test "list_intensities/0 returns all intensities" do
      intensity = intensity_fixture()
      assert Measure.list_intensities() == [intensity]
    end

    test "get_intensity!/1 returns the intensity with given id" do
      intensity = intensity_fixture()
      assert Measure.get_intensity!(intensity.id) == intensity
    end

    test "create_intensity/1 with valid data creates a intensity" do
      assert {:ok, %Intensity{} = intensity} = Measure.create_intensity(@valid_attrs)
      assert intensity.actual == 42
      assert intensity.forecast == 42
      assert intensity.from_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert intensity.index == "some index"
      assert intensity.to_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_intensity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Measure.create_intensity(@invalid_attrs)
    end

    test "update_intensity/2 with valid data updates the intensity" do
      intensity = intensity_fixture()
      assert {:ok, %Intensity{} = intensity} = Measure.update_intensity(intensity, @update_attrs)
      assert intensity.actual == 43
      assert intensity.forecast == 43
      assert intensity.from_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert intensity.index == "some updated index"
      assert intensity.to_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_intensity/2 with invalid data returns error changeset" do
      intensity = intensity_fixture()
      assert {:error, %Ecto.Changeset{}} = Measure.update_intensity(intensity, @invalid_attrs)
      assert intensity == Measure.get_intensity!(intensity.id)
    end

    test "delete_intensity/1 deletes the intensity" do
      intensity = intensity_fixture()
      assert {:ok, %Intensity{}} = Measure.delete_intensity(intensity)
      assert_raise Ecto.NoResultsError, fn -> Measure.get_intensity!(intensity.id) end
    end

    test "change_intensity/1 returns a intensity changeset" do
      intensity = intensity_fixture()
      assert %Ecto.Changeset{} = Measure.change_intensity(intensity)
    end

    test "get_latest/1 returns latest record from database" do
      t1 = ~U[2021-03-11 22:00:00Z]
      t2 = ~U[2021-03-11 22:30:00Z]
      Carbon.Repo.insert(%Intensity{from_time: t1, to_time: t2, actual: 333})

      latest = Measure.get_latest()
      assert latest.actual == 333
      assert latest.to_time == t2
    end
  end
end
