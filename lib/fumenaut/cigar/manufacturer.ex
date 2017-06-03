defmodule Fumenaut.Cigar.Manufacturer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fumenaut.Cigar.Manufacturer


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cigar_manufacturers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Manufacturer{} = manufacturer, attrs) do
    manufacturer
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
