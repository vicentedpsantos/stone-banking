defmodule StoneWeb.UsersView do
  use StoneWeb, :view
  alias Stone.Schemas.{User, Account}

  def render("create.json", %{user: %User{
    email: email,
    first_name: first_name,
    last_name: last_name,
    inserted_at: inserted_at},
    account: %Account{
      balance_in_cents: balance_in_cents
    }
  }) do
    %{
      message: "Usuário #{first_name} #{last_name} foi criado!",
      user: %{
        email: email,
        first_name: first_name,
        last_name: last_name,
        inserted_at: inserted_at,
        account: %{
          balance: Money.to_string(Money.new(balance_in_cents))
        }
      }
    }
  end
end

