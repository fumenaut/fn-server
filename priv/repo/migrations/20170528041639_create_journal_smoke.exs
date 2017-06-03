defmodule Fumenaut.Repo.Migrations.CreateFumenaut.Journal.Smoke do
  use Ecto.Migration

  def change do
    create table(:journal_smokes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text
      add :user_id, references(:account_users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:journal_smokes, [:user_id])
  end
end
