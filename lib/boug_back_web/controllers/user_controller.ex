defmodule BougBackWeb.UserController do
  use BougBackWeb, :controller

  alias BougBack.{Accounts, Accounts.User}
  alias BougBackWeb.{Auth.Guardian, Auth.ErrorResponse}

  plug :is_authorized_account when action in [:update, :delete]
  plug :is_admin_account when action in [:index]

  action_fallback BougBackWeb.FallbackController

  defp is_authorized_account(conn, _opts) do
    id = Plug.Conn.get_session(conn, :user_id)
    %{params: %{"id" => params_id}} = conn
    if id == params_id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  defp is_admin_account(conn, _opts) do
    id = Plug.Conn.get_session(conn, :user_id)
    user = Accounts.get_user!(id)
    if user.role.admin do
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
      if user.email == System.get_env("ADMIN_EMAIL") do
        Accounts.create_role(%{"admin" => true, "moderator" => true, "user_id" => user.id})
      else
        Accounts.create_role(%{"admin" => false, "moderator" => false, "user_id" => user.id})
      end
      authorize_account(conn, user.email, user_params["password"])
    end
  end

  def sign_in(conn, %{"user" => user_params}) do
    authorize_account(conn, user_params["email"], user_params["password"])
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        IO.inspect(user)
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render("user_token.json", %{user: user, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def refresh_session(conn, _) do
    token = Guardian.Plug.current_token(conn)
    {:ok, user, new_token} = Guardian.authenticate(token)
    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> put_status(:ok)
    |> render("user_session.json", %{user: user, token: new_token})
  end

  def sign_out(conn, _) do
    user = conn.assigns[:user]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("user_session.json", %{user: user, token: nil})
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_full_user(id)
    render(conn, "full_user.json", user: user)
  end

  def current_user(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render("full_user.json", %{user: conn.assigns.user})
  end

  def profil_pic(conn, %{"id" => id}) do
    pic = Accounts.get_profil_pic(id)
    if is_nil(pic.profil_img) do
      conn
      |> put_status(:ok)
      |> json(%{no_pic: "Pas de profil pic"})
    else
      conn
      |> send_resp(200, pic.profil_img)
    end
  end

  def update(conn, %{"id" => id, "current_hash" => current_hash, "user" => user_params, "profil_img" => profil_pic}) do
    ecto_user = Accounts.get_user!(id)
    token = Guardian.Plug.current_token(conn)
    {:ok, _token, {new_token, _claims}} = Guardian.refresh(token)
    case Guardian.validate_password(current_hash, ecto_user.password) do
      true ->
        if (File.exists?(profil_pic.path)) do
          case File.read(profil_pic.path) do
            {:ok, profil_img} -> data = IO.iodata_to_binary(profil_img)
              user = Map.put(user_params, "profil_img", data)
              filtered_user = Map.reject(user, fn {_key, val} -> val == "" end)
              {:ok, resp_user} = Accounts.update_user(ecto_user, filtered_user)
              render(conn, "user_session.json", %{user: resp_user, token: new_token})
            {:error, posix} ->
              conn
              |> json(%{error: "Error reading the profil pic #{posix}"})
          end
        end
      false ->
        raise ErrorResponse.Unauthorized, message: "Password incorrect."
    end
  end

  def update(conn, %{"id" => id, "current_hash" => current_hash, "user" => user_params}) do
    ecto_user = Accounts.get_user!(id)
    token = Guardian.Plug.current_token(conn)
    {:ok, _token, {new_token, _claims}} = Guardian.refresh(token)
    case Guardian.validate_password(current_hash, ecto_user.password) do
      true ->
        filtered_user = Map.reject(user_params, fn {_key, val} -> val == "" end)
        {:ok, resp_user} = Accounts.update_user(ecto_user, filtered_user)
        render(conn, "user_session.json", %{user: resp_user, token: new_token})
      false ->
        raise ErrorResponse.Unauthorized, message: "Password incorrect."
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
