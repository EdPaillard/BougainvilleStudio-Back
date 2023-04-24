defmodule BougBackWeb.UserController do
  use BougBackWeb, :controller

  alias BougBack.{Accounts, Accounts.User}
  alias BougBackWeb.{Auth.Guardian, Auth.ErrorResponse}

  plug :is_authorized_account when action in [:update, :delete]

  action_fallback BougBackWeb.FallbackController

  defp is_authorized_account(conn, _opts) do
    %{params: %{"user" => params}} = conn
    if conn.assigns.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      authorize_account(conn, user.email, user_params["password"])
    end
  end

  def sign_in(conn, %{"user" => user_params}) do
    authorize_account(conn, user_params["email"], user_params["password"])
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render("user_token.json", %{user: user, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)
    {:ok, user, new_token} = Guardian.authenticate(token)
    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: new_token})
  end

  def sign_out(conn, _) do
    user = conn.assigns[:user]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: nil})
  end

  def show(conn, %{"user_id" => id}) do
    user = Accounts.get_full_user(id)
    render(conn, "full_user.json", user: user)
  end

  def current_user(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render("full_user.json", %{user: conn.assigns.user})
  end

  def update(conn, %{"current_hash" => current_hash, "user" => user_params}) do
    case Guardian.validate_password(current_hash, conn.assigns.user.password) do
      true ->
        {:ok, user} = Accounts.update_user(conn.assigns.user, user_params)
        render(conn, "show.json", user: user)
      false -> raise ErrorResponse.Unauthorized, message: "Password incorrect."
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
