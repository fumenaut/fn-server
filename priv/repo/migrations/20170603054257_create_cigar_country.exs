defmodule Fumenaut.Repo.Migrations.CreateFumenaut.Cigar.Country do
  use Ecto.Migration

  def change do
    create table(:cigar_countries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
