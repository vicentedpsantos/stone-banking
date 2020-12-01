defmodule Stone.Concepts.Deposit do
  alias Stone.Operations.CreditAccount
  alias Stone.Repo
  alias Ecto.Multi

  def call(params) do
    sanitized_params = sanitize_params(params)
    multi = Multi.new()

    with {:error, error} <- CreditAccount.call(multi, sanitized_params) do
      {:error, error}
    else
      multi -> Repo.transaction(multi)
    end
  end

  defp sanitize_params(params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_existing_atom(key), val) end)
    |> Map.put_new(:description, "deposit")
  end
end
