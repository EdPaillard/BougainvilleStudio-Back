defmodule BougBackWeb.TropheeController do
  use BougBackWeb, :controller

  alias BougBack.Accounts
  alias BougBack.Accounts.Trophee

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    trophees = Accounts.list_trophees()
    render(conn, "index.json", trophees: trophees)
  end

  def create(conn, %{"trophee" => trophee_params}) do
    with {:ok, %Trophee{} = trophee} <- Accounts.create_trophee(trophee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.trophee_path(conn, :show, trophee))
      |> render("show.json", trophee: trophee)
    end
  end

  def show(conn, %{"id" => id}) do
    trophee = Accounts.get_trophee!(id)
    render(conn, "show.json", trophee: trophee)
  end

  def update(conn, %{"id" => id, "trophee" => trophee_params}) do
    trophee = Accounts.get_trophee!(id)

    with {:ok, %Trophee{} = trophee} <- Accounts.update_trophee(trophee, trophee_params) do
      render(conn, "show.json", trophee: trophee)
    end
  end

  def delete(conn, %{"id" => id}) do
    trophee = Accounts.get_trophee!(id)

    with {:ok, %Trophee{}} <- Accounts.delete_trophee(trophee) do
      send_resp(conn, :no_content, "")
    end
  end
end
