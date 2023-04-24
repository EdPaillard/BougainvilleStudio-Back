defmodule BougBackWeb.FragmentController do
  use BougBackWeb, :controller

  alias BougBack.{Content, Content.Fragment, Ftp.Server}

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    fragments = Content.list_fragments()
    render(conn, "index.json", fragments: fragments)
  end

  def create(conn, %{"fragment" => fragment_params}) do
    file = Enum.map(fragment_params["content"], &(&1["file"]))
    fragment = Map.update(fragment_params, "content", nil, fn cont ->
      Enum.map(cont, fn file ->
        Map.delete(file, "file")
      end)
    end)

    with {:ok, %Fragment{} = fragment} <- Content.create_fragment(fragment),
         {:ok, stream} <- Server.upload_file(file) do

      inspect(item: stream, label: "STREAM")

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.fragment_path(conn, :show, fragment))
      |> render("show.json", fragment: fragment)
    end
  end

  def show(conn, %{"id" => id}) do
    fragment = Content.get_fragment!(id)
    render(conn, "show.json", fragment: fragment)
  end

  def update(conn, %{"id" => id, "fragment" => fragment_params}) do
    fragment = Content.get_fragment!(id)

    with {:ok, %Fragment{} = fragment} <- Content.update_fragment(fragment, fragment_params) do
      render(conn, "show.json", fragment: fragment)
    end
  end

  def delete(conn, %{"id" => id}) do
    fragment = Content.get_fragment!(id)

    with {:ok, %Fragment{}} <- Content.delete_fragment(fragment) do
      send_resp(conn, :no_content, "")
    end
  end
end
