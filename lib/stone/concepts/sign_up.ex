defmodule Stone.Concepts.SignUp do
  alias Ecto.Multi
  alias Stone.Operations.{Users, Accounts}

  def call(params) do
    params
    |> multi()
    |> Stone.Repo.transaction()
  end

  def multi(params) do
    Multi.new()
    |> Multi.run(:user, fn repo, _changes -> Users.Create.call(params) end)
  end
end
