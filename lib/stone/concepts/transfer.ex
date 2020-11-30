defmodule Stone.Concepts.Transfer do
  alias Stone.Operations.{CreditAccount, DebitAccount}
  alias Stone.Repo

  def call(params) do
    with {:ok, _} <- credit_account(params),
         {:ok, _} <- debit_account(params) do

      {:ok, params}
    else
      {:error, _, _} -> {:error, :unprocessable_entity}
    end
  end

  def credit_account(params) do
    params
    |> CreditAccount.call() 
    |> Repo.transaction()
  end

  def debit_account(params) do
    params
    |> DebitAccount.call()
    |> Repo.transaction()
  end
end
