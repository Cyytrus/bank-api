defmodule BankApi.Operations do
  alias BankApi.Accounts
  alias BankApi.Accounts.Account
  alias BankApi.Repo

  def transfer(from_account_id, to_account_id, value) do
    from = Accounts.get!(from_account_id)
    value = Decimal.new(value)

    case is_negative?(from.balance, value) do
      true -> {:error, "Você não pode ter saldo negativo!"}
      false -> perform_update(from, to_account_id, value)
    end
  end

  def withdraw(from_account_id, value) do
    from = Accounts.get!(from_account_id)
    value = Decimal.new(value)

    case is_negative?(from.balance, value) do
      true ->
        {:error, "Você não pode ter saldo negativo!"}

      false ->
        {:ok, from} = perform_operation(from, value, :sub) |> Repo.update()
        {:ok, "Saque de R$ #{value} feito com sucesso por #{from.id}!"}
    end
  end

  defp is_negative?(from_balance, value) do
    Decimal.sub(from_balance, value)
    |> Decimal.negative?()
  end

  def perform_update(from, to_account_id, value) do
    to = Accounts.get!(to_account_id)

    transaction =
      Ecto.Multi.new()
      |> Ecto.Multi.update(:from_account, perform_operation(from, value, :sub))
      |> Ecto.Multi.update(:to_account, perform_operation(from, value, :sum))
      |> Repo.transaction()

    case transaction do
      {:ok, _} ->
        {:ok, "Transferência feita com sucesso de: #{from.id} para: #{to.id}, valor: #{value}"}

      {:error, :from_account, changeset, _} ->
        {:error, changeset}

      {:error, :to_account, changeset, _} ->
        {:error, changeset}
    end
  end

  def perform_operation(account, value, :sub) do
    account
    |> update_account(%{balance: Decimal.sub(account.balance, value)})
  end

  def perform_operation(account, value, :sum) do
    account
    |> update_account(%{balance: Decimal.add(account.balance, value)})
  end

  def update_account(%Account{} = account, attrs) do
    Account.changeset(account, attrs)
  end
end
