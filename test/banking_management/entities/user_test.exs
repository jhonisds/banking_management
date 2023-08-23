defmodule BankingManagement.Entities.UserTest do
  use BankingManagement.DataCase, async: true

  alias BankingManagement.Entities.User

  @valid_attrs %{
    name: "User",
    email: "employee@employee.com",
    document: Brcpfcnpj.cpf_generate(true),
    password: "123456"
  }

  describe "changeset" do
    test "creates valid changeset when all parameters are valid" do
      changeset = User.changeset(@valid_attrs)

      assert changeset.valid?
    end

    test "returns error when changeset is missing any required field" do
      changeset = User.changeset(%{})

      assert Enum.sort(changeset.errors) ==
               Enum.sort(
                 name: {"can't be blank", [validation: :required]},
                 email: {"can't be blank", [validation: :required]},
                 document: {"can't be blank", [validation: :required]},
                 password: {"can't be blank", [validation: :required]}
               )
    end

    for email <- [
          "plainaddress",
          "invalid@",
          "#@%^%#$@#$@#.com",
          "@example.com",
          "Joe Smith <email@example.com>",
          "email.example.com",
          "email@example@example.com",
          ".email@example.com",
          "email.@example.com",
          "email..email@example.com",
          "あいうえお@example.com",
          "email@example.com (Joe Smith)",
          "email@-example.com",
          "email@example..com",
          "Abc..123@example.com"
        ] do
      test "returns error when email is not a valid email (#{email})" do
        changeset = User.changeset(%{email: unquote(email)})
        assert "has invalid format" in errors_on(changeset).email
      end
    end

    for email <- [
          "prettyandsimple@example.com",
          "very.common@example.com",
          "name+123@example.com",
          "disposable.style.email.with+symbol@example.com",
          "other.email-with-dash@example.com",
          "some.email+@hotmail.com",
          "some.email!@hotmail.com",
          "email@example.com",
          "firstname.lastname@example.com",
          "email@subdomain.example.com",
          "firstname+lastname@example.com",
          "email@123.123.123.123",
          "1234567890@example.com",
          "email@example-one.com",
          "_______@example.com",
          "email@example.name",
          "email@example.museum",
          "email@example.co.jp",
          "firstname-lastname@example.com"
        ] do
      test "does not return error when email is a valid email (#{email})" do
        changeset = User.changeset(%{email: unquote(email)})
        refute errors_on(changeset)[:email]
      end
    end
  end
end
