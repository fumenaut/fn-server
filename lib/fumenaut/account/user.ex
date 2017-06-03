defmodule Fumenaut.Account.User do
  @moduledoc """
  Fumenaut module providing account user database schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias Fumenaut.Account.User
  alias Fumenaut.Journal.Smoke

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "account_users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :smokes, Smoke

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :smokes])
    |> validate_required([:email, :username, :smokes])
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email], [:password])
    |> validate_required([:username, :email])
    |> put_pass_hash()
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
