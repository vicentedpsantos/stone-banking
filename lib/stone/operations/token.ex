defmodule Stone.Operations.Token do
  @token_size 32

  def transaction_token do
    :crypto.strong_rand_bytes(@token_size)
    |> Base.encode64()
    |> binary_part(0, @token_size)
  end
end
