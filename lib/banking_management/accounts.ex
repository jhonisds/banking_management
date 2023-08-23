defmodule BankingManagement.Accounts do
  @moduledoc """
    Accounts module.
  """

  alias BankingManagement.Interactors.Account.Create
  alias BankingManagement.Interactors.Account.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
