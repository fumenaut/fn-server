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
end
