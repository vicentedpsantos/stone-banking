defmodule StoneWeb.UsersController do
  use StoneWeb, :controller

  action_fallback StoneWeb.FallbackController

  def create(conn, params) do
    params
    |> Stone.create_user()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:ok, %{user: user, account: account}}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, user: user, account: account)
  end

  defp handle_response({:error, :user, changeset, _}, _conn, _view, _status) do
    {:error, changeset}
  end
end
