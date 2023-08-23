defmodule BankingManagement.Interactors.User.Update do
  @moduledoc """
    This module is responsible for updating an existing user.
  """

  alias BankingManagement.Entities.User
  alias BankingManagement.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> update(user, params)
    end
  end

  defp update(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
