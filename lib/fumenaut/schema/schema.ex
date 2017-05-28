defmodule Fumenaut.Schema do
  @moduledoc """
  Fumenaut GraphQL schema.
  """

  use Absinthe.Schema
  import_types Fumenaut.Schema.Types

  alias Fumenaut.Schema.SmokeResolver
  alias Fumenaut.Schema.UserResolver

  query do
    field :smokes, list_of(:smoke) do
      resolve &SmokeResolver.all/2
    end

    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end
  end
end
