defmodule Stone.Schemas.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Stone.Schemas.{User, Transaction}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "accounts" do
    field :balance_in_cents, :integer
    belongs_to(:user, User)
    has_many(:transactions, Transaction)
    timestamps()
  end

  @required_create_params [:balance_in_cents, :user_id]

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_create_params)
    |> validate_required(@required_create_params)
    |> validate_number(:balance_in_cents, greater_than_or_equal_to: 0)
  end

  @allowed_fields [:balance_in_cents]

  def deposit_changeset(account, incoming_amount) do
    account
    |> change()
    |> deposit_balance_in_cents(incoming_amount)
  end

  defp deposit_balance_in_cents(changeset, incoming_amount_in_cents) do
    current_balance_in_cents = changeset |> get_field(:balance_in_cents)

    put_change(changeset, :balance_in_cents, current_balance_in_cents + incoming_amount_in_cents)
  end

  def withdrawal_changeset(account, incoming_amount) do
    account
    |> change()
    |> withdrawal_balance_in_cents(incoming_amount)
    |> validate_number(:balance_in_cents, greater_than_or_equal_to: 0)
  end

  defp withdrawal_balance_in_cents(changeset, incoming_amount_in_cents) do
    current_balance_in_cents = changeset |> get_field(:balance_in_cents)

    put_change(changeset, :balance_in_cents, current_balance_in_cents - incoming_amount_in_cents)
  end
end
