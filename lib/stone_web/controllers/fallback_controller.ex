defmodule StoneWeb.FallbackController do
  use StoneWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render_view("Not found")
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> render_view(result)
  end

  defp render_view(conn, result) do
    conn
    |> put_view(StoneWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
