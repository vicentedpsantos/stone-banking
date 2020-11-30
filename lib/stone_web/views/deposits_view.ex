defmodule StoneWeb.DepositsView do
  use StoneWeb, :view
  alias Stone.Schemas.{Transaction, Account}
  import StoneWeb.Views.MoneyParser

  def render(
        "create.json",
        %{
          account: %Account{
            balance_in_cents: balance,
            id: id
          },
          transaction: %Transaction{
            amount_in_cents: amount_deposited,
            description: description,
            transaction_hash: confirmation_code
          }
        }
      ) do
    %{
      message: "Depósito realizado com sucesso",
      account: %{
        new_balance: money_string(balance),
        amount_deposited: money_string(amount_deposited),
        transaction_type: description,
        confirmation_code: confirmation_code
      }
    }
  end
end
