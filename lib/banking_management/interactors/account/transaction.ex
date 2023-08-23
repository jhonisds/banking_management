defmodule BankingManagement.Interactors.Account.Transaction do
  @moduledoc """
    This module is responsible for creating a transaction between accounts.
  """

  alias Ecto.Multi

  alias BankingManagement.Entities.Account
  alias BankingManagement.Repo

  def call(
        %{
          "from_account_id" => from_account_id,
          "to_account_id" => to_account_id,
          "amount" => amount
        } = _params
      ) do
    with %Account{} = from_account <- Repo.get(Account, from_account_id),
         %Account{} = to_account <- Repo.get(Account, to_account_id),
         {:ok, amount} <- Decimal.cast(amount) do
      Multi.new()
      |> withdraw(from_account, amount)
      |> deposit(to_account, amount)
      |> Repo.transaction()
      |> handle_output()
    else
      nil -> {:error, :not_found}
      :error -> {:error, "Invalid amount"}
    end
  end

  def call(_), do: {:error, "Invalid params"}

  defp withdraw(multi, to_account, amount) do
    new_balance = Decimal.sub(to_account.balance, amount)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, from_account, amount) do
    new_balance = Decimal.add(from_account.balance, amount)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp handle_output({:ok, _result} = result), do: result

  defp handle_output({:error, _operation, reason, _}), do: {:error, reason}
end
