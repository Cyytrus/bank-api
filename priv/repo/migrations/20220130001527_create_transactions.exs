defmodule BankApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :decimal
      add :from_account, :string
      add :to_account, :string
      add :type, :string
      add :date, :date

      timestamps()
    end
  end
end
