defmodule BankingManagementWeb.FallbackController do
  use BankingManagementWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: BankingManagementWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BankingManagementWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, msg}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BankingManagementWeb.ErrorJSON)
    |> render(:error, msg: msg)
  end
end