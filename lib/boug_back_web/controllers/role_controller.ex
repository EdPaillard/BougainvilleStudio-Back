defmodule BougBackWeb.RoleController do
  use BougBackWeb, :controller

  alias BougBack.Accounts
  alias BougBack.Accounts.Role
  alias BougBackWeb.Auth.ErrorResponse


  plug :is_authorized_account when action in [:create, :update, :delete]

  defp is_authorized_account(conn, _opts) do
    if conn.assigns.user.role.admin do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    roles = Accounts.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Accounts.create_role(role_params) do
      conn
      |> put_status(:created)
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Accounts.get_role!(id)

    with {:ok, %Role{} = role} <- Accounts.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)

    with {:ok, %Role{}} <- Accounts.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
