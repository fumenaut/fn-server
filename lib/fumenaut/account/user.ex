defmodule Fumenaut.Account.User do
  @moduledoc """
  Fumenaut module providing account user database schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fumenaut.Account.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "account_users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
  end
end
