defmodule BankApiWeb.UserController do
  use BankApiWeb, :controller
  alias BankApi.Accounts

  action_fallback BankApiWeb.FallbackController

  def signup(conn, %{"user" => user}) do
    with {:ok, user, account} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> render("account.json", %{user: user, account: account})
    end
  end
end
