defmodule Carbon.Intensity do
  use Ecto.Schema

  import Ecto.Changeset

  schema "intensities" do
    field :from_time, :utc_datetime
    field :to_time,   :utc_datetime
    field :actual,    :integer
    timestamps()
  end

  def changeset(intensity, params \\ %{}) do
    intensity
    |> cast(params, [:from_time, :to_time, :actual])
    |> validate_required([:from_time, :to_time, :actual])
    |> unique_constraint(:from_time, name: :intensities_from_time_to_time_index)
  end

end
