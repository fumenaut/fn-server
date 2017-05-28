defmodule Fumenaut.Journal do
  @moduledoc """
  The boundary for the Journal system.
  """

  import Ecto.Query, warn: false
  alias Fumenaut.Repo

  alias Fumenaut.Journal.Smoke

  @doc """
  Returns the list of smokes.

  ## Examples

      iex> list_smokes()
      [%Smoke{}, ...]

  """
  def list_smokes do
    Repo.all(Smoke)
  end

  @doc """
  Gets a single smoke.

  Raises `Ecto.NoResultsError` if the Smoke does not exist.

  ## Examples

      iex> get_smoke!(123)
      %Smoke{}

      iex> get_smoke!(456)
      ** (Ecto.NoResultsError)

  """
  def get_smoke!(id), do: Repo.get!(Smoke, id)

  @doc """
  Creates a smoke.

  ## Examples

      iex> create_smoke(%{field: value})
      {:ok, %Smoke{}}

      iex> create_smoke(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_smoke(attrs \\ %{}) do
    %Smoke{}
    |> Smoke.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a smoke.

  ## Examples

      iex> update_smoke(smoke, %{field: new_value})
      {:ok, %Smoke{}}

      iex> update_smoke(smoke, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_smoke(%Smoke{} = smoke, attrs) do
    smoke
    |> Smoke.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Smoke.

  ## Examples

      iex> delete_smoke(smoke)
      {:ok, %Smoke{}}

      iex> delete_smoke(smoke)
      {:error, %Ecto.Changeset{}}

  """
  def delete_smoke(%Smoke{} = smoke) do
    Repo.delete(smoke)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking smoke changes.

  ## Examples

      iex> change_smoke(smoke)
      %Ecto.Changeset{source: %Smoke{}}

  """
  def change_smoke(%Smoke{} = smoke) do
    Smoke.changeset(smoke, %{})
  end
end
