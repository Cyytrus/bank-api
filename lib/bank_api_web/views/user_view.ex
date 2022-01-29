defmodule BankApiWeb.UserView do
  use BankApiWeb, :view

  def render("account.json", %{user: user, account: account}) do
    %{
      balance: account.balance,
      account_id: account.id,
      user: %{
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        role: user.role,
        id: user.id
      }
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      role: user.role,
      account: %{
        id: user.accounts.id,
        balance: user.accounts.balance
      }
    }
  end
end
