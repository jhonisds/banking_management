defmodule BankingManagement.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")

      add :balance, :decimal, null: false
      add :user_id, references(:users, type: :uuid), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create constraint(:accounts, :positive_balance, check: "balance >= 0")

    create unique_index(:accounts, [:user_id], name: "unique_user_id")
  end
end
