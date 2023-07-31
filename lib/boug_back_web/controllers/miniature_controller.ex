defmodule BougBackWeb.MiniatureController do
  require Image
  use BougBackWeb, :controller

  alias BougBack.Content
  alias BougBack.Content.Miniature

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    miniatures = Content.list_miniatures()
    render(conn, "index.json", miniatures: miniatures)
  end

  def test(conn, %{"miniature" => miniature}) do
    if(File.exists?(miniature.path)) do
      case File.read(miniature.path) do
        {:ok, _} -> {:ok, vix_image} = Vix.Vips.Image.new_from_file(miniature.path)
          IO.inspect(vix_image)
          IO.inspect(Image.BandFormat.known_band_formats)
          IO.inspect(Vix.Vips.Image.height(vix_image))
          IO.inspect(Vix.Vips.Image.width(vix_image))
          IO.inspect(Vix.Vips.Image.format(vix_image))
          Image.dominant_color()
          rgb = Image.dominant_color(vix_image)
          IO.inspect(rgb)
          new_rgb = Enum.map(rgb, fn el -> 255 - el end)
          conn
          |> put_status(:ok)
          |> json(%{dom: rgb, new: new_rgb})
        {:error, posix} -> IO.inspect(item: posix, label: "Posix Error")
      end
    end
  end

  def create(conn, %{"miniature" => miniature, "id" => id}) do
    if(File.exists?(miniature.path)) do
      case File.read(miniature.path) do
        {:ok, body} -> data = IO.iodata_to_binary(body)
        miniature_params = %{"mini" => data, "fragment_id" => id}
        with {:ok, _miniature} <- Content.create_miniature(miniature_params) do
          conn
          |> put_status(:created)
          |> json(%{success: "Miniature created successfuly"})
        end
        {:error, posix} -> IO.inspect(item: posix, label: "Posix Error")
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
