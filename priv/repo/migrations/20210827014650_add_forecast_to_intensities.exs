defmodule Carbon.Repo.Migrations.AddForecastToIntensities do
  use Ecto.Migration

  def change do
    alter table(:intensities) do
      add :forecast, :integer
      add :index, :string
    end
  end
end
