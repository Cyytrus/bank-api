defmodule BankApi.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BankApi.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        date: ~D[2022-01-29],
        from_account: "some from_account",
        to_account: "some to_account",
        type: "some type",
        value: "120.5"
      })
      |> BankApi.Transactions.create_transaction()

    transaction
  end
end
