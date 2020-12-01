defmodule Stone.Operations.DebitAccount do
  alias Ecto.Multi
  alias Stone.Schemas.{User, Account, Transaction}
  alias Stone.Repo

  @withdrawal_nature "debit"

  import Stone.Operations.Token

  def call(multi, params) do
    case fetch_dependencies(params) do
      nil -> {:error, :not_found}
      user -> user
    end
    |> multi(multi, params)
  end

  defp fetch_dependencies(params) do
    Repo.get_by(User, email: Map.fetch!(params, :debited_account))
    |> Repo.preload(:account)
  end

  defp multi({:error, :not_found}, _, _), do: {:error, :not_found}

  defp multi(%User{account: account}, multi, params) do
    token = transaction_token()
    merged_params = Map.merge(params, %{token: token})

    multi
    |> Multi.insert(
      :debit_transaction,
      Transaction.create_changeset(transaction_changeset(account, merged_params))
    )
    |> Multi.update(:account_debit, Account.withdrawal_changeset(account, Map.fetch!(params, :amount_in_cents)))
  end

  defp transaction_changeset(account, %{amount_in_cents: amount_in_cents, token: token, description: description}) do
    %{
      description: description,
      nature: @withdrawal_nature,
      amount_in_cents: amount_in_cents,
      account_id: account.id,
      transaction_hash: token
    }
  end
end
