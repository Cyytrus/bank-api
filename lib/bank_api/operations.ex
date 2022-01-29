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

  defp is_negative?(from_balance, value) do
    Decimal.sub(from_balance, value)
    |> Decimal.negative?()
  end

  def perform_update(from, to_account_id, value) do
    {:ok, from} = perform_operation(from, value, :sub)
    {:ok, to} = Accounts.get!(to_account_id)
    |> perform_operation(value, :sum)
    {:ok, "Transferência feita com sucesso de: #{from.id} para: #{to.id}, valor: #{value}"}
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
    |> Repo.update()
  end
end
