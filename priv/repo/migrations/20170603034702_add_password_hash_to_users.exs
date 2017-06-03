defmodule Fumenaut.Repo.Migrations.AddPasswordHashToUsers do
  use Ecto.Migration

  def change do
    alter table(:account_users) do
      add :password_hash, :string
    end
  end
end
