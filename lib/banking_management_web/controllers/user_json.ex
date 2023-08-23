defmodule BankingManagementWeb.UserJSON do
  alias BankingManagement.Entities.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}) do
    %{
      message: "User updated successfully",
      data: data(user)
    }
  end

  def delete(%{user: _user}) do
    %{
      message: "User deleted successfully"
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      document: user.document
    }
  end
end
