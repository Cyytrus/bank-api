defmodule BankApi.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "transactions" do
    field :date, :date
    field :from_account, :string
    field :to_account, :string
    field :type, :string
    field :value, :decimal

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :from_account, :to_account, :type, :date])
    |> validate_required([:value, :from_account, :to_account, :type, :date])
  end
end
