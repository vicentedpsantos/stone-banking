defmodule StoneWeb.Views.MoneyParser do
  def money_string(money) when is_integer(money) do
    money
    |> Money.new()
    |> Money.to_string()
  end
end
