defmodule Stone.Concepts.Deposit do
  alias Ecto.Multi
  alias Stone.Schemas.{User, Account, Transaction}
  alias Stone.Repo

  def call(params) do
    case fetch_dependencies(params) do
      nil -> {:error, :not_found}
      user -> user
    end
    |> multi(params)
    |> Repo.transaction()
  end

  defp fetch_dependencies(%{email: email, amount_in_cents: amount}) do
    Repo.get_by(User, email: email)
    |> Repo.preload(:account)
  end

  defp multi({:error, error}, params), do: {:error, error}

  defp multi(%User{account: account}, params) do
    token = transaction_token()
    merged_params = Map.merge(params, %{token: token})

    Multi.new()
    |> Multi.insert(
      :transaction,
      Transaction.create_changeset(transaction_changeset(account, merged_params))
    )
    |> Multi.update(:account, account_changeset(account, params))
  end

  @deposit_description "deposit"
  @deposit_nature "credit"

  defp transaction_changeset(account, %{amount_in_cents: amount_in_cents, token: token}) do
    %{
      description: @deposit_description,
      nature: @deposit_nature,
      amount_in_cents: amount_in_cents,
      account_id: account.id,
      transaction_hash: token
    }
  end

  defp transaction_token do
    :crypto.strong_rand_bytes(32)
    |> Base.encode64()
    |> binary_part(0, 32)
  end

  defp account_changeset(%Account{balance_in_cents: current_balance} = account, %{
         amount_in_cents: incoming_amount
       }) do
    Ecto.Changeset.change(account, balance_in_cents: current_balance + incoming_amount)
  end
end
