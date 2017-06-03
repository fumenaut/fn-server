defmodule Fumenaut.Cigar.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fumenaut.Cigar.Country


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cigar_countries" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
