defmodule BankApi.TransactionsTest do
  use BankApi.DataCase

  alias BankApi.Transactions

  describe "transactions" do
    alias BankApi.Transactions.Transaction

    import BankApi.TransactionsFixtures

    @invalid_attrs %{date: nil, from_account: nil, to_account: nil, type: nil, value: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{date: ~D[2022-01-29], from_account: "some from_account", to_account: "some to_account", type: "some type", value: "120.5"}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.date == ~D[2022-01-29]
      assert transaction.from_account == "some from_account"
      assert transaction.to_account == "some to_account"
      assert transaction.type == "some type"
      assert transaction.value == Decimal.new("120.5")
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{date: ~D[2022-01-30], from_account: "some updated from_account", to_account: "some updated to_account", type: "some updated type", value: "456.7"}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.date == ~D[2022-01-30]
      assert transaction.from_account == "some updated from_account"
      assert transaction.to_account == "some updated to_account"
      assert transaction.type == "some updated type"
      assert transaction.value == Decimal.new("456.7")
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
