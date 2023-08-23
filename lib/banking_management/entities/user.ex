defmodule BankingManagement.Entities.User do
  @moduledoc """
    User schema.
    This schema contains the user fields needed for banking domain.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias BankingManagement.Entities.Account
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :email, :string
    field :document, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :deleted_at, :utc_datetime_usec

    has_one :account, Account

    timestamps()
  end

  @fields [
    :name,
    :email,
    :document,
    :password,
    :deleted_at
  ]

  @required_fields @fields -- [:deleted_at]

  # Based on https://www.ietf.org/rfc/rfc2822.txt
  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @email_validation_regex ~r/^([a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)$/i

  @doc false
  def changeset do
    changeset(%__MODULE__{}, %{})
  end

  def changeset(%__MODULE__{} = user) do
    changeset(user, %{})
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(%__MODULE__{} = user, %{} = attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, @email_validation_regex)
    |> unique_constraint(:document, name: "unique_user_document")
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset
end
