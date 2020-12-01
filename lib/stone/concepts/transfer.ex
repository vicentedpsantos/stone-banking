defmodule Stone.Concepts.Transfer do
  alias Stone.Operations.{CreditAccount, DebitAccount}
  alias Stone.Repo
  alias Ecto.Multi

  def call(params) do
    sanitized_params = sanitize_params(params)

    Multi.new() 
    |> Multi.merge(fn _ -> 
      Multi.new()
      |> credit_account(sanitized_params)
    end) 
    |> Multi.merge(fn _ ->
      Multi.new()
      |> debit_account(sanitized_params)
    end)
    |> Repo.transaction()
  end

  defp credit_account(multi, params) do
    CreditAccount.call(multi, params)
  end

  defp debit_account(multi, params) do
    DebitAccount.call(multi, params)
  end

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "transfer")
  end
end
