defmodule Stone.Concepts.Withdrawal do
  alias Stone.Operations.DebitAccount
  alias Stone.Repo

  @withdrawal_description "withdrawal"

  def call(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_atom(key), val) end)
    |> Map.put_new(:description, @withdrawal_description)
    |> DebitAccount.call()
    |> Repo.transaction()
  end
end
