defmodule BougBackWeb.FragmentController do
  use BougBackWeb, :controller

  alias BougBack.{Content, Content.Fragment}

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
    fragments = Content.get_sample_frags()
    # map_fragments = Enum.map(fragments, fn frag -> Map.from_struct(frag) end)
    # full_frags = Enum.map(fragments, fn frag ->
    #   miniature = Webdav.download_file(frag[:miniature])
    #   Map.put(frag, :miniature, miniature)
    # end)
    render(conn, "index.json", fragments: fragments)
  end

  def create(conn, %{"fragment" => fragment_params}) do
    with {:ok, %Fragment{} = fragment} <- Content.create_fragment(fragment_params) do
      render(conn, "created_fragment.json", fragment: fragment)
      # conn
      # |> put_status(:created)
      # |> json(%{success: Map.from_struct(fragment)})
    end
  end

  # defp build_content(content1, content2, content3, params) do
  #   case [content1, content2, content3] do
  #     [_, nil, nil] ->
  #       Map.put(params, "content", List.update_at(params["content"], 0, fn el -> Map.put(el, "body", content1) end))
  #     [_, _, nil] ->
  #       Map.put(params, "content", List.update_at(params["content"], 1, fn el -> Map.put(el, "body", content2) end))
  #     [_, _, _] ->
  #       Map.put(params, "content", List.update_at(params["content"], 2, fn el -> Map.put(el, "body", content3) end))
  #   end
  # end

  def show(conn, %{"id" => id}) do
    fragment = Content.get_fragment!(id)
    render(conn, "show.json", fragment: fragment)
    # fragment = Content.get_fragment!(id)
    # map_fragment = Map.from_struct(fragment)
    # content = Enum.map(map_fragment[:content], fn element -> Webdav.download_file(element["path"]) end)
    # miniature = Webdav.download_file(map_fragment[:miniature])
    # if Enum.any?(content, fn element -> is_tuple(element) end) do
    #   error = Enum.at(content, 0)
    #   conn
    #   |> put_status(:forbidden)
    #   |> json(%{error: Jason.encode!(elem(error, 1))})
    # else
    #   full_frag =
    #     Map.put(map_fragment, :file, content)
    #     |> Map.put(:miniature, miniature)
    #   render(conn, "full_fragment.json", fragment: full_frag)
    # end
  end

  def sample_two_last_frags(conn, _params) do
    fragments = Content.get_sample_two_last_frags()
    # map_fragments = Enum.map(fragments, fn frag -> Map.from_struct(frag) end)
    render(conn, "index.json", fragments: fragments)
  end

  def meta(conn, %{"id" => id}) do
    fragment = Content.meta(id)
    render(conn, "meta.json", fragment: fragment)
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
