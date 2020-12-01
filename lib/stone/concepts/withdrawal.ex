defmodule Stone.Concepts.Withdrawal do
  alias Stone.Operations.DebitAccount
  alias Stone.Repo
  alias Ecto.Multi

  @withdrawal_description "withdrawal"

  def call(params) do
    sanitized_params = sanitize_params(params)
    multi = Multi.new()

    with {:error, error} <- DebitAccount.call(multi, sanitized_params) do
      {:error, error}
    else
      multi -> Repo.transaction(multi)
    end
  end

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "withdrawal")
  end
end
