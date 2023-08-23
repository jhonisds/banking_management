defmodule BankingManagement.Users do
  @moduledoc """
    Users module.
  """

  alias BankingManagement.Interactors.User.Create
  alias BankingManagement.Interactors.User.Get
  alias BankingManagement.Interactors.User.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
