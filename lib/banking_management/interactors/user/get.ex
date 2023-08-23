defmodule BankingManagement.Interactors.User.Get do
  @moduledoc """
    This module is.
  """
  import Ecto.Query, warn: false

  alias BankingManagement.Entities.User
  alias BankingManagement.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
