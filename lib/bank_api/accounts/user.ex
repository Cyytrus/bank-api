defmodule BankApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true }
  @derive {Phoenix.Param, key: :id}
  schema "users" do
    # field :id, :uuid, primary_key: true
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :role, :string, default: "user"

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :role
    ])
    |> validate_required(
      [
        :email,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :role
      ]
    )
    |> validate_format(:email, ~r/@/, message: "email em formato inválido" )
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100, message: "Password deve estar entre 6 a 100 caracteres.")
    |> validate_confirmation(:password, message: "Password não está igual")
    |> unique_constraint(:email, message: "Já existe um usuário com esse e-mail")
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: false} = changeset) do
    changeset
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    Ecto.Changeset.change(changeset, Argon2.add_hash(password))
  end
end
