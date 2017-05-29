defmodule Fumenaut.Schema.SmokeResolver do
  @moduledoc """
  Fumenaut GraphQL Smoke resolver.
  """

  alias Fumenaut.Repo
  alias Fumenaut.Journal.Smoke

  def all(_args, _info) do
    {:ok, Repo.all(Smoke)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Smoke, id) do
      nil -> {:error, "Smoke id #{id} not found"}
      smoke -> {:ok, smoke}
    end
  end

  def create(args, _info) do
    %Smoke{}
    |> Smoke.changeset(args)
    |> Repo.insert
  end

  def update(%{id: id, smoke: smoke_params}, _info) do
    Repo.get!(Smoke, id)
    |> Smoke.changeset(smoke_params)
    |> Repo.update
  end

  def delete(%{id: id}, _info) do
    smoke = Repo.get!(Smoke, id)
    Repo.delete(smoke)
  end
end
