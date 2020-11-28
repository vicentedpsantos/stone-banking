defmodule Stone.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Stone.Schemas.Account

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :email, :string
    has_one(:account, Account)
    timestamps()
  end

  @required_params [:first_name, :last_name, :password, :email]

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:first_name, min: 2, max: 20)
    |> validate_length(:last_name, min: 2, max: 20)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 40)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
