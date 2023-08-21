defmodule BankingManagement.Repo do
  use Ecto.Repo,
    otp_app: :banking_management,
    adapter: Ecto.Adapters.Postgres
end
