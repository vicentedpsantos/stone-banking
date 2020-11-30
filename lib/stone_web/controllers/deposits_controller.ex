defmodule StoneWeb.DepositsController do
  use StoneWeb, :controller

  action_fallback StoneWeb.FallbackController

  def create(conn, params) do
    params
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, String.to_atom(key), val) end)
    |> Stone.create_deposit()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:ok, %{account: account, transaction: transaction}}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, account: account, transaction: transaction)
  end

  defp handle_response({:error, :account, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end

  defp handle_response({:error, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end
end
