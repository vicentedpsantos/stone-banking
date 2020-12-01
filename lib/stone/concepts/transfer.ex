defmodule Stone.Concepts.Transfer do
  alias Stone.Operations.{CreditAccount, DebitAccount}
  alias Stone.Repo
  alias Ecto.Multi

  def call(params) do
    sanitized_params = sanitize_params(params)

    Multi.new()
    |> Multi.merge(fn _ -> credit_account(sanitized_params) end)
    |> Multi.merge(fn _ -> debit_account(sanitized_params) end)
    |> Repo.transaction()
  end

  defp credit_account(params), do: CreditAccount.call(Multi.new(), params)
  defp debit_account(params), do: DebitAccount.call(Multi.new(), params)

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "transfer")
  end
end
