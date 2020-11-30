defmodule Stone.Concepts.Withdrawal do
  alias Stone.Operations.DebitAccount
  alias Stone.Repo
  alias Ecto.Multi

  @withdrawal_description "withdrawal"

  def call(params) do
    new_params = sanitize_params(params)

    Multi.new()
    |> DebitAccount.call(new_params)
    |> Repo.transaction()
  end

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "withdrawal")
  end
end
