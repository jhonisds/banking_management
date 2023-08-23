defmodule BankingManagement.Interactors.User.Create do
  @moduledoc """
    This module is responsible for creating a new user.
  """

  alias BankingManagement.Entities.User
  alias BankingManagement.Repo

  def call(%{} = input) do
    %User{}
    |> User.changeset(input)
    |> Repo.insert()
  end
end
