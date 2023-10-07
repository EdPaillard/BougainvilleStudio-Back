defmodule BougBackWeb.TrophyController do
  use BougBackWeb, :controller

  alias BougBack.Accounts
  alias BougBack.Accounts.Trophy

  alias BougBackWeb.Auth.ErrorResponse

  plug :is_authorized_account when action in [:create, :update, :delete]

  action_fallback BougBackWeb.FallbackController

  defp is_authorized_account(conn, _opts) do
    if conn.assigns.user.role.admin do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def index(conn, _params) do
    trophies = Accounts.list_trophies()
    render(conn, "index.json", trophies: trophies)
  end

  def create(conn, %{"trophy" => trophy_params}) do
    with {:ok, %Trophy{} = trophy} <- Accounts.create_trophy(trophy_params) do
      conn
      |> put_status(:created)
      |> render("show.json", trophy: trophy)
    end
  end

  def show(conn, %{"id" => id}) do
    trophy = Accounts.get_trophy!(id)
    render(conn, "show.json", trophy: trophy)
  end

  def update(conn, %{"id" => id, "trophy" => trophy_params}) do
    trophy = Accounts.get_trophy!(id)

    with {:ok, %Trophy{} = trophy} <- Accounts.update_trophy(trophy, trophy_params) do
      render(conn, "show.json", trophy: trophy)
    end
  end

  def delete(conn, %{"id" => id}) do
    trophy = Accounts.get_trophy!(id)

    with {:ok, %Trophy{}} <- Accounts.delete_trophy(trophy) do
      send_resp(conn, :no_content, "")
    end
  end
end
