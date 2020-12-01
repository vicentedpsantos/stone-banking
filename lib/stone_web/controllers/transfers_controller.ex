defmodule StoneWeb.TransfersController do
  use StoneWeb, :controller

  alias Stone.Repo

  action_fallback StoneWeb.FallbackController

  def create(conn, params) do
    params
    |> Stone.create_transfer()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:ok, response}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, response)
  end

  defp handle_response({:error, :account, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end

  defp handle_response({:error, :transaction, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end
end
