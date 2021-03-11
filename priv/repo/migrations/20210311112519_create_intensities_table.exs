defmodule Carbon.Repo.Migrations.CreateIntensitiesTable do
  use Ecto.Migration

  def change do
    create table("intensities") do
      add :from_time, :utc_datetime
      add :to_time,   :utc_datetime
      add :actual,    :integer
      timestamps()
    end
    create index("intensities", [:from_time, :to_time], unique: true)
  end
end
