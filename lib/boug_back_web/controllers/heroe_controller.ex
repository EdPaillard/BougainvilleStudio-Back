defmodule BougBackWeb.HeroeController do
  use BougBackWeb, :controller

  alias BougBack.Content
  alias BougBack.Content.Heroe

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    heroes = Content.list_heroes()
    render(conn, "index.json", heroes: heroes)
  end

  def create(conn, %{"heroe" => heroe_params}) do
    with {:ok, %Heroe{} = heroe} <- Content.create_heroe(heroe_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.heroe_path(conn, :show, heroe))
      |> render("show.json", heroe: heroe)
    end
  end

  def show(conn, %{"id" => id}) do
    heroe = Content.get_heroe!(id)
    render(conn, "show.json", heroe: heroe)
  end

  def update(conn, %{"id" => id, "heroe" => heroe_params}) do
    heroe = Content.get_heroe!(id)

    with {:ok, %Heroe{} = heroe} <- Content.update_heroe(heroe, heroe_params) do
      render(conn, "show.json", heroe: heroe)
    end
  end

  def delete(conn, %{"id" => id}) do
    heroe = Content.get_heroe!(id)

    with {:ok, %Heroe{}} <- Content.delete_heroe(heroe) do
      send_resp(conn, :no_content, "")
    end
  end
end
