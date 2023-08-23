defmodule BankingManagement.Entities.Account do
  @moduledoc """
    Account schema.
    This schema contains the accounts fields needed for banking domain.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias BankingManagement.Entities.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts" do
    field :balance, :decimal

    belongs_to :user, User, type: Ecto.UUID

    timestamps()
  end

  @fields [
    :balance,
    :user_id
  ]

  @required_fields @fields

  @doc false
  def changeset do
    changeset(%__MODULE__{}, %{})
  end

  def changeset(%__MODULE__{} = account) do
    changeset(account, %{})
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(%__MODULE__{} = account, %{} = attrs) do
    account
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> check_constraint(:balance, name: "positive_balance")
    |> unique_constraint(:user_id, name: "unique_user_id")
  end
end
