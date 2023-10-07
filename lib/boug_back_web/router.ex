defmodule BougBackWeb.Router do
  use BougBackWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.Parsers,
      parsers: [:urlencoded, :multipart]
    plug :fetch_session
  end

  pipeline :auth do
    plug BougBackWeb.Auth.Pipeline
    plug BougBackWeb.Auth.SetUser
  end

  scope "/api", BougBackWeb do
    pipe_through :api
  end

  scope "/", BougBackWeb do
    pipe_through :api
    post "/register", UserController, :register
    post "/login", UserController, :sign_in
    pipe_through :auth
    get "/logout", UserController, :sign_out
  end

  scope "/user", BougBackWeb do
    pipe_through :api
    get "/pic/:id", UserController, :profil_pic
    pipe_through :auth
    get "/refresh_session", UserController, :refresh_session
    get "/", UserController, :index
    get "/:id", UserController, :show
    get "/current", UserController, :current_user
    put "/:id", UserController, :update
    delete "/:id", UserController, :delete
  end
  scope "/roles", BougBackWeb do
    pipe_through [:api, :auth]
    resources "/", RoleController, except: [:new, :edit]
  end

  scope "/fragment", BougBackWeb do
    pipe_through :api
    get "/", FragmentController, :index
    get "/sample", FragmentController, :sample_two_last_frags
    get "/meta/:id", FragmentController, :meta
    get "/:id", FragmentController, :show
    pipe_through :auth
    post "/", FragmentController, :create
    put "/:id", FragmentController, :update
    delete "/:id", FragmentController, :delete
  end

  scope "/content", BougBackWeb do
    pipe_through :api
    get "/", ContentsController, :index
    get "/:id", ContentsController, :show
    pipe_through :auth
    post "/", ContentsController, :create
    delete "/:id", ContentsController, :delete
  end

  scope "/miniature", BougBackWeb do
    pipe_through :api
    get "/", MiniatureController, :index
    get "/:id", MiniatureController, :show
    pipe_through :auth
    post "/", MiniatureController, :create
    post "/test", MiniatureController, :test
    delete "/:id", MiniatureController, :delete
  end

  scope "/heroe", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", HeroeController, :index
    get "/:id", HeroeController, :show
    post "/", HeroeController, :create
    put "/:id", HeroeController, :update
    delete "/:id", HeroeController, :delete
  end

  scope "/timeline", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", TimelineController, :index
    get "/:id", TimelineController, :show
    post "/", TimelineController, :create
    put "/:id", TimelineController, :update
    delete "/:id", TimelineController, :delete
  end

  scope "/trophy", BougBackWeb do
    pipe_through [:api, :auth]
    get "/", TrophyController, :index
    get "/:id", TrophyController, :show
    post "/", TrophyController, :create
    put "/:id", TrophyController, :update
    delete "/:id", TrophyController, :delete
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
