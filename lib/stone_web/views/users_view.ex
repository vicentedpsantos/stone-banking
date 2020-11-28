defmodule StoneWeb.UsersView do
  use StoneWeb, :view
  alias Stone.Schemas.User

  def render("create.json", %{user: %User{email: email, first_name: first_name, last_name: last_name, inserted_at: inserted_at}}) do
    %{
      message: "user #{first_name} has been created!",
      user: %{
        email: email,
        first_name: first_name,
        last_name: last_name,
        inserted_at: inserted_at
      }
    }
  end
end

