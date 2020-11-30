defmodule Stone.Concepts.SignUp do
  alias Ecto.Multi
  alias Stone.Schemas.{User, Account}
  alias Stone.Repo

  @initial_balance 1000_00

  def call(params) do
    params
    |> multi()
    |> Repo.transaction()
  end

  def multi(params) do
    Multi.new()
    |> Multi.insert(:user, User.changeset(params))
    |> Multi.run(:account, fn repo, %{user: user} ->
      account_params = %{
        user_id: user.id,
        balance_in_cents: @initial_balance_in_cents
      }

      Account.create_changeset(account_params)
      |> Repo.insert()
    end)
  end
end
