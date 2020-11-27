defmodule StoneWeb.Router do
  use StoneWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StoneWeb do
    pipe_through :api

    resources "/users", UsersController, only: [:create]
  end
end
