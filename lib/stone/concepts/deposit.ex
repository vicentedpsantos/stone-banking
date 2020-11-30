defmodule Stone.Concepts.Deposit do
  alias Stone.Operations.CreditAccount
  alias Stone.Repo

  def call(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_atom(key), val) end)
    |> Map.put_new(:description, "deposit")
    |> CreditAccount.call()
    |> Repo.transaction()
  end
end
