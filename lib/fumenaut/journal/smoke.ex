defmodule Fumenaut.Journal.Smoke do
  @moduledoc """
  Fumenaut module providing smoke journal database schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fumenaut.Journal.Smoke


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "journal_smokes" do
    field :body, :string
    field :title, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(%Smoke{} = smoke, attrs) do
    smoke
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
