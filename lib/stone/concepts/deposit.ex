defmodule Stone.Concepts.Deposit do
  alias Stone.Operations.CreditAccount
  alias Stone.Repo
  alias Ecto.Multi

  def call(params) do
    new_params = sanitize_params(params)

    Multi.new()
    |> CreditAccount.call(new_params)
    |> Repo.transaction()
  end

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "deposit")
  end
end
