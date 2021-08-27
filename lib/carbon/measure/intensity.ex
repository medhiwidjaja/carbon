defmodule Carbon.Measure.Intensity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intensities" do
    field :actual, :integer
    field :forecast, :integer
    field :from_time, :utc_datetime
    field :index, :string
    field :to_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(intensity, attrs) do
    intensity
    |> cast(attrs, [:from_time, :to_time, :actual, :forecast, :index])
    |> validate_required([:from_time, :to_time, :actual, :forecast, :index])
    |> unique_constraint(:from_time, name: :intensities_from_time_to_time_index)
  end
end
