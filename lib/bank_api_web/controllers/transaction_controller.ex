defmodule BankApiWeb.TransactionController do
  use BankApiWeb, :controller
  action_fallback BankApiWeb.FallbackController

  def all(conn, _) do
    render(conn, "Show.json", transaction: Transactions.all)
  end

  def all(conn, _) do
    render(conn, "Show.json", transaction: Transactions.all)
  end

  def all(conn, _) do
    render(conn, "Show.json", transaction: Transactions.all)
  end

  def all(conn, _) do
    render(conn, "Show.json", transaction: Transactions.all)
  end
end
