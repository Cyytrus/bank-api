defmodule BankApi.Accounts do
  alias BankApi.Repo
  alias BankApi.Accounts.{Account, User}

  def create_user(attrs \\ %{}) do
    transaction =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:user, insert_user(attrs))
      |> Ecto.Multi.insert(:account, fn %{user: user} ->
        user
        |> Ecto.build_assoc(:accounts)
        |> Account.changeset()
      end)
      |> Repo.transaction()

    case transaction do
      {:ok, operations} -> {:ok, operations.user, operations.account}
      {:error, :user, changeset, _} -> {:error, changeset}
    end
  end

  defp insert_user(attrs) do
    %User{}
    |> User.changeset(attrs)
  end
end
