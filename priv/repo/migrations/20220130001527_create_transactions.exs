defmodule BankApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :value, :decimal, precision: 10, scale: 2
      add :from_account, :string
      add :to_account, :string
      add :type, :string
      add :date, :date

      timestamps()
    end
  end
end
