defmodule BankingManagement.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")

      add :name, :string, null: false, size: 60
      add :email, :string, null: false
      add :document, :string, null: false
      add :password_hash, :string, null: false

      add :deleted_at, :utc_datetime_usec
      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:users, [:document],
             name: "unique_user_document",
             where: "deleted_at IS NULL"
           )

    create index(:users, :deleted_at)
  end
end
