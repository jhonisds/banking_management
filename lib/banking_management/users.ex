defmodule BankingManagement.Users do
  @moduledoc """
    Users module.
  """

  alias BankingManagement.Interactors.User.Auth
  alias BankingManagement.Interactors.User.Create
  alias BankingManagement.Interactors.User.Get
  alias BankingManagement.Interactors.User.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate auth(params), to: Auth, as: :call
end
