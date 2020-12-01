defmodule StoneWeb.DepositsController do
  use StoneWeb, :controller

  alias Stone.Repo

  action_fallback StoneWeb.FallbackController

  def create(conn, params) do
    params
    |> Stone.create_deposit()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response(
         {:ok, %{account_credit: account, credit_transaction: transaction}},
         conn,
         view,
         status
       ) do
    conn
    |> put_status(status)
    |> render(view, account: account, transaction: transaction)
  end

  defp handle_response({:error, :account, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end

  defp handle_response({:error, :not_found}, _conn, _view, _status), do: {:error, :not_found}

  defp handle_response({:error, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end
end
