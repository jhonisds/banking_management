defmodule BankingManagementWeb.UserControllerTest do
  use BankingManagementWeb.ConnCase

  alias BankingManagement.Entities.User

  @valid_attrs %{
    name: "John Doe",
    email: "test@test.com",
    document: "12345678900",
    password: "12345678"
  }

  describe "create/2" do
    test "creates an user", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users", @valid_attrs)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "document" => "12345678900",
                 "email" => "test@test.com",
                 "id" => _id,
                 "name" => "John Doe"
               },
               "message" => "User created successfully"
             } = response
    end

    test "return an error to create a user", %{conn: conn} do
      input = Map.put(@valid_attrs, :document, "")

      response =
        conn
        |> post(~p"/api/users", input)
        |> json_response(:bad_request)

      assert %{"errors" => %{"document" => ["can't be blank"]}} = response
    end
  end
end
