defmodule Stone do
  alias Stone.Concepts.{SignUp, Deposit, Withdrawal, Transfer}

  defdelegate create_user(params), to: SignUp, as: :call

  defdelegate create_deposit(params), to: Deposit, as: :call
  defdelegate create_withdrawal(params), to: Withdrawal, as: :call
  defdelegate create_transfer(params), to: Transfer, as: :call
end
