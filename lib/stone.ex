defmodule Stone do
  alias Stone.Concepts.{SignUp, Deposit}

  defdelegate create_user(params), to: SignUp, as: :call
  defdelegate create_deposit(params), to: Deposit, as: :call
end
