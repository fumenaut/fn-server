defmodule Fumenaut.Repo.Migrations.CreateFumenaut.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :username, :string

      timestamps()
    end

  end
end
