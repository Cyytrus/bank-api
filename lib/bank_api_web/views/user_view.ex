defmodule BankApiWeb.UserView do
  use BankApiWeb, :view

  def render("account.json", %{account: account}) do
    %{balance: account.balance,
      account_id: account.id,
      user: %{
        email: account.user.email,
        first_name: account.user.first_name,
        last_name: account.user.last_name,
        role: account.user.role,
        id: account.user.id,
      }
    }
  end
end
