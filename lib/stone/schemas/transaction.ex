defmodule Stone.Schemas.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Stone.Schemas.Account

  @foreign_key_type Ecto.UUID

  schema "transactions" do
    field :description, :string
    field :nature, :string
    field :amount_in_cents, :integer
    field :transaction_hash, :string
    belongs_to(:account, Account)
    timestamps()
  end

  @required_create_params [:nature, :description, :amount_in_cents, :transaction_hash, :account_id]

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_create_params)
    |> validate_required(@required_create_params)
    |> validate_number(:amount_in_cents, greater_than_or_equal_to: 0)
    |> validate_inclusion(:nature, ["debit", "credit"])
  end
end
