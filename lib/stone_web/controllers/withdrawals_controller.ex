defmodule StoneWeb.WithdrawalsController do
  use StoneWeb, :controller

  alias Stone.Repo

  action_fallback StoneWeb.FallbackController

  def create(conn, params) do
    params
    |> Stone.create_withdrawal()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response(
         {:ok, %{account_debit: account, debit_transaction: transaction}},
         conn,
         view,
         status
       ) do
    conn
    |> put_status(status)
    |> render(view, account: account, transaction: transaction)
  end

  defp handle_response({:error, :account, :transaction, changeset, _}, _conn, _view, _status),
    do: {:error, changeset}

  defp handle_response({:error, :not_found}, _conn, _view, _status), do: {:error, :not_found}

  defp handle_response({:error, :account, changeset, _}, _conn, _view, _status),
    do: {:error, changeset}

  defp handle_response({:error, :transaction, changeset, _}, _conn, _view, _status),
    do: {:error, changeset}
end
