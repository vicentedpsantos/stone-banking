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

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_create_params)
    |> validate_required(@required_create_params)
    |> validate_number(:balance_in_cents, greater_than_or_equal_to: 0)
  end
end
