defmodule BougBackWeb.Router do
  use BougBackWeb, :router
  use Plug.ErrorHandler

  # defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  #   conn |> json(%{errors: message}) |> halt()
  # end

  # defp handle_errors(conn, %{reason: %{message: message}}) do
  #   conn |> json(%{errors: message}) |> halt()
  # end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug BougBackWeb.Auth.Pipeline
    # plug BougBackWeb.Auth.SetUser
  end

  scope "/api", BougBackWeb do
    pipe_through :api
  end

  scope "/", BougBackWeb do
    pipe_through :api
    post "/register", UserController, :register
    post "/login", UserController, :sign_in
    get "/logout", UserController, :sign_out
  end

  scope "/user", BougBackWeb do
    pipe_through [:api, :auth]
    get "/refresh_session", UserController, :refresh_session
    get "/", UserController, :list
    get "/:user_id", UserController, :show
    get "/current", UserController, :current_user
    put "/:user_id", UserController, :update
    delete "/:user_id", UserController, :delete
  end

  scope "/fragment", BougBackWeb do
    pipe_through :api
    get "/", FragmentController, :list
    get "/:frag_id", FragmentController, :show
    post "/", FragmentController, :create
    put "/:frag_id", FragmentController, :update
    delete "/:frag_id", FragmentController, :delete
  end

  scope "/heroe", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", HeroeController, :list
    get "/:heroe_id", HeroeController, :show
    post "/", HeroeController, :create
    put "/:heroe_id", HeroeController, :update
    delete "/:heroe_id", HeroeController, :delete
  end

  scope "/timeline", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", TimelineController, :list
    get "/:timeline_id", TimelineController, :show
    post "/", TimelineController, :create
    put "/:timeline_id", TimelineController, :update
    delete "/:timeline_id", TimelineController, :delete
  end

  scope "/trophee", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", TropheeController, :list
    get "/:trophee_id", TropheeController, :show
    post "/", TropheeController, :create
    put "/:trophee_id", TropheeController, :update
    delete "/:trophee_id", TropheeController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BougBackWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
