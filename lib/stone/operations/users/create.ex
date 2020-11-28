defmodule Stone.Operations.Users.Create do
  alias Stone.Repo
  alias Stone.Schemas.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
