defmodule Fumenaut.Schema.Types do
  @moduledoc """
  Fumenaut GraphQL schema types.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Fumenaut.Repo

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :smokes, list_of(:smoke), resolve: assoc(:smokes)
  end

  object :smoke do
    field :id, :id
    field :title, :string
    field :body, :string
    field :user, :user, resolve: assoc(:user)
  end
end
