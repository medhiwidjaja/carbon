defmodule Carbon.Measure do
  @moduledoc """
  The Measure context.
  """

  import Ecto.Query, warn: false
  alias Carbon.Repo

  alias Carbon.Measure.Intensity

  @doc """
  Returns the list of intensities.

  ## Examples

      iex> list_intensities()
      [%Intensity{}, ...]

  """
  def list_intensities do
    Repo.all(Intensity)
  end

  @doc """
  Gets a single intensity.

  Raises `Ecto.NoResultsError` if the Intensity does not exist.

  ## Examples

      iex> get_intensity!(123)
      %Intensity{}

      iex> get_intensity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_intensity!(id), do: Repo.get!(Intensity, id)

  @doc """
  Creates a intensity.

  ## Examples

      iex> create_intensity(%{field: value})
      {:ok, %Intensity{}}

      iex> create_intensity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_intensity(attrs \\ %{}) do
    %Intensity{}
    |> Intensity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a intensity.

  ## Examples

      iex> update_intensity(intensity, %{field: new_value})
      {:ok, %Intensity{}}

      iex> update_intensity(intensity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_intensity(%Intensity{} = intensity, attrs) do
    intensity
    |> Intensity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a intensity.

  ## Examples

      iex> delete_intensity(intensity)
      {:ok, %Intensity{}}

      iex> delete_intensity(intensity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_intensity(%Intensity{} = intensity) do
    Repo.delete(intensity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking intensity changes.

  ## Examples

      iex> change_intensity(intensity)
      %Ecto.Changeset{data: %Intensity{}}

  """
  def change_intensity(%Intensity{} = intensity, attrs \\ %{}) do
    Intensity.changeset(intensity, attrs)
  end

  def get_latest() do
    Repo.one(from e in Intensity, order_by: [desc: :to_time], limit: 1)
  end

  def paginate_intensities(params \\ []) do
    Intensity
    |> Repo.paginate(params)
  end
end
