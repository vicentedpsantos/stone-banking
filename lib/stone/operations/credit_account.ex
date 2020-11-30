defmodule Stone.Operations.CreditAccount do
  alias Ecto.Multi
  alias Stone.Schemas.{User, Account, Transaction}
  alias Stone.Repo

  @deposit_nature "credit"

  import Stone.Operations.Token

  @spec call(Multi.t(), map()) :: Multi.t()
  def call(multi, params) do
    case fetch_dependencies(params) do
      nil -> {:error, :not_found}
      user -> user
    end
    |> multi(multi, params)
  end

  defp fetch_dependencies(params) do
    Repo.get_by(User, email: Map.fetch!(params, :credited_account))
    |> Repo.preload(:account)
  end

  defp multi({:error, error}, params), do: {:error, error}

  defp multi(%User{account: account}, multi, params) do
    token = transaction_token()
    merged_params = Map.merge(params, %{token: token})

    multi
    |> Multi.insert(
      :transaction,
      Transaction.create_changeset(transaction_changeset(account, merged_params))
    )
    |> Multi.update(:account, Account.deposit_changeset(account, Map.fetch!(params, :amount_in_cents)))
  end

  defp transaction_changeset(account, %{amount_in_cents: amount_in_cents, token: token, description: description}) do
    %{
      description: description,
      nature: @deposit_nature,
      amount_in_cents: amount_in_cents,
      account_id: account.id,
      transaction_hash: token
    }
  end
end
