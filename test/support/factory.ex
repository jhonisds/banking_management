defmodule BankingManagement.Support.Factory do
  @moduledoc """
    Factory used to create entities for tests.
  """

  # with Ecto
  use ExMachina.Ecto, repo: BankingManagement.Repo

  alias BankingManagement.Entities.User

  def user_factory do
    name = sequence(:name, &"User #{&1}")
    document = Brcpfcnpj.cpf_generate()
    email = "#{String.replace(name, " ", "_")}@user_email.com"

    %User{
      id: Ecto.UUID.generate(),
      name: name,
      email: email,
      document: document,
      password_hash: "123456",
      deleted_at: nil
    }
  end
end
