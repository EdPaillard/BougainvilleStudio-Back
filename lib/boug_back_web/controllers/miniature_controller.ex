defmodule BougBackWeb.MiniatureController do
  require Image
  use BougBackWeb, :controller

  alias BougBack.Content
  alias BougBack.Content.Miniature

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
    miniatures = Content.list_miniatures()
    render(conn, "index.json", miniatures: miniatures)
  end

  def create(conn, %{"miniature" => miniature, "id" => id}) do
    if(File.exists?(miniature.path)) do
      case File.read(miniature.path) do
        {:ok, body} ->
          data = IO.iodata_to_binary(body)
          case Vix.Vips.Image.new_from_file(miniature.path) do
            {:ok, vix_image} ->
              rgb = Image.dominant_color(vix_image[0..2])
              new_rgb = Enum.map(rgb, fn el -> 255 - el end)
              miniature_params = %{"mini" => data, "bg_color" => new_rgb, "fragment_id" => id}
              with {:ok, _miniature} <- Content.create_miniature(miniature_params) do
                conn
                |> put_status(:created)
                |> json(%{success: "Miniature created successfuly"})
              end
            {:error, error} ->
              conn
              |> put_status(400)
              |> json(%{err: error})
          end
        {:error, posix} ->
          conn
          |> json(%{error: "Error reading the profil pic #{posix}"})
      end
    end
  end

  def show(conn, %{"id" => id}) do
    miniature = Content.get_miniature!(id)
    data = miniature.mini
    conn
    |> send_resp(200, data)
    #render(conn, "show.json", miniature: miniature)
  end

  # def update(conn, %{"id" => id, "miniature" => miniature_params}) do
  #   miniature = Content.get_miniature!(id)

  #   with {:ok, %Miniature{} = miniature} <- Content.update_miniature(miniature, miniature_params) do
  #     render(conn, "show.json", miniature: miniature)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    miniature = Content.get_miniature!(id)

    with {:ok, %Miniature{}} <- Content.delete_miniature(miniature) do
      send_resp(conn, :no_content, "")
    end
  end
end
