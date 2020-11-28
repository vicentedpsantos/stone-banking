defmodule Stone do
  alias Stone.Concepts.SignUp

  defdelegate create_user(params), to: SignUp, as: :call
end
