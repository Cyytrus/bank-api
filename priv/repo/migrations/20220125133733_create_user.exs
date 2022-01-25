defmodule BankApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :role, :string
      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
