defmodule Stone do
  alias Stone.Concepts.{SignUp, Deposit, Withdrawal}

  defdelegate create_user(params), to: SignUp, as: :call
  defdelegate create_deposit(params), to: Deposit, as: :call
  defdelegate create_withdrawal(params), to: Withdrawal, as: :call
end
