defmodule BougBackWeb.FragmentController do
  use BougBackWeb, :controller

  alias BougBack.{Content, Content.Fragment, Webdav}

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    fragments = Content.list_fragments()
    content = Enum.map(fragments, fn element ->
      Enum.map(element["content"], fn element_content ->
        Webdav.download_file(element_content["path"]) end)
    end)
    all_frags =
      Enum.zip(fragments, content)
      |> Enum.map(fn {fragment, frag_content} ->
        Map.put(fragment, :file, frag_content)
      end)
    render(conn, "index.json", fragments: all_frags)
  end

  def create(conn, %{"fragment" => fragment_params}) do
    with {:ok, %Fragment{} = fragment} <- Content.create_fragment(fragment_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.fragment_path(conn, :show, fragment))
      |> render("show.json", fragment: fragment)
    end
  end

  def show(conn, %{"id" => id}) do
    fragment = Content.get_fragment!(id)
    content = Enum.map(fragment["content"], fn element -> Webdav.download_file(element["path"]) end)
    full_frag = Map.put(fragment, :file, content)
    render(conn, "full_fragment.json", fragment: full_frag)
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
