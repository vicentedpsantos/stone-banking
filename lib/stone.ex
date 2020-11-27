defmodule Stone do
  alias Stone.Concepts.{Users}

  defdelegate create_user(params), to: Users.Create, as: :call
end
