defmodule BankingManagement.Interactors.Account.Create do
  @moduledoc """
    This module is responsible for creating a new account.
  """

  alias BankingManagement.Entities.Account
  alias BankingManagement.Repo

  def call(%{} = input) do
    %Account{}
    |> Account.changeset(input)
    |> Repo.insert()
  end
end
