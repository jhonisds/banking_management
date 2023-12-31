defmodule BankingManagementWeb.UserController do
  use BankingManagementWeb, :controller

  alias BankingManagement.Entities.User
  alias BankingManagement.Users

  alias BankingManagementWeb.FallbackController
  alias BankingManagementWeb.Token

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end

  def auth(conn, params) do
    with {:ok, %User{} = user} <- Users.auth(params) do
      token = Token.sign(user)

      conn
      |> put_status(:ok)
      |> render(:auth, token: token)
    end
  end
end
