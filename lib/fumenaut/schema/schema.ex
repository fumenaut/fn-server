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

  mutation do
    field :create_smoke, type: :smoke do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :user_id, non_null(:id)

      resolve &SmokeResolver.create/2
    end

    field :update_smoke, type: :smoke do
      arg :id, non_null(:id)
      arg :smoke, :update_smoke_params

      resolve &SmokeResolver.update/2
    end

    field :delete_smoke, type: :smoke do
      arg :id, non_null(:id)

      resolve &SmokeResolver.delete/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:id)
      arg :user, :update_user_params

      resolve &UserResolver.update/2
    end
  end
end
