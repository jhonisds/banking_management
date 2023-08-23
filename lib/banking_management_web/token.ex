defmodule BankingManagementWeb.Token do
  @moduledoc """
   Token module.
  """

  alias BankingManagementWeb.Endpoint
  alias Phoenix.Token

  @key_salt "banking_management_web:token"
  @max_age 86_400

  def sign(user) do
    Token.sign(Endpoint, @key_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @key_salt, token, max_age: @max_age)
end
