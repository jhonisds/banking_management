defmodule BankingManagementWeb.Router do
  use BankingManagementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BankingManagementWeb.Plugs.Auth
  end

  scope "/api", BankingManagementWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    post "/auth", UserController, :auth
  end

  scope "/api", BankingManagementWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController, only: [:update, :delete, :show]
    resources "/accounts", AccountController, only: [:create]
    post "/accounts/transaction", AccountController, :transaction
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:banking_management, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BankingManagementWeb.Telemetry
    end
  end
end
