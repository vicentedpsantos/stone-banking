defmodule StoneWeb.TransfersView do
  use StoneWeb, :view
  alias Stone.Schemas.{Transaction, Account}
  import StoneWeb.Views.MoneyParser

  def render(
        "create.json",
        %{
          account_credit: credited_account,
          account_debit: debited_account,
          credit_transaction: credit_transaction,
          debit_transaction: debit_transaction
        }
      ) do
    %{
      message: "Transferencia realizada com sucesso",
      amount_in_cents: credit_transaction.amount_in_cents,
      confirmation_code: credit_transaction.transaction_hash
    }
  end
end
