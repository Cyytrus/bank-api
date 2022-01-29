defmodule BankApiWeb.OperationController do
  use BankApiWeb, :controller

  def transfer(conn, %{
        "from_account_id" => from_account_id,
        "to_account_id" => to_account_id,
        "value" => value
      }) do
    IO.inspect(from_account_id)
    IO.inspect(to_account_id)
    IO.inspect(value)

    conn
    |> render("success.json", message: "Transferencia realizada com sucesso!")
  end
end
