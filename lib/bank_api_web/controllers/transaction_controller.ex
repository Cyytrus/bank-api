defmodule BankApiWeb.TransactionController do
  use BankApiWeb, :controller
  alias BankApi.Transactions
  action_fallback BankApiWeb.FallbackController

  def all(conn, _) do
    render(conn, "show.json", transaction: Transactions.all())
  end

  def year(conn, %{"year" => year}) do
    render(conn, "show.json", transaction: Transactions.all)
  end

  def month(conn, %{"year" => year, "month" => month}) do
    render(conn, "show.json", transaction: Transactions.all)
  end

  def day(conn, %{"day" => day}) do
    render(conn, "show.json", transaction: Transactions.all)
  end
end
