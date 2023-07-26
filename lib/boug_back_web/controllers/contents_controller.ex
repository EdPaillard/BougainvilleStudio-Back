defmodule BougBackWeb.ContentsController do
  use BougBackWeb, :controller

  alias BougBack.Content
  alias BougBack.Content.Contents

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    contents = Content.list_contents()
    render(conn, "index.json", contents: contents)
  end

  def create(conn, %{"content" => content, "id" => id, "type" => type}) do
    IO.inspect(content)
    if(File.exists?(content.path)) do
      case File.read(content.path) do
        {:ok, body} -> data = IO.iodata_to_binary(body)
        content_params = %{"body" => data, "fragment_id" => id, "type" => type}
        with {:ok, _contents} <- Content.create_contents(content_params) do
          conn
          |> put_status(:created)
          |> json(%{success: "Content created successfuly"})
        end
        {:error, posix} -> IO.inspect(item: posix, label: "Posix Error")
      end
    end
  end

  # defp set_content_type(file_name) do

  # end

  def show(conn, %{"id" => id}) do
    contents = Content.get_contents!(id)
    chunk_size = 1024

    data = contents.body

    chunk = chunk_entry(data, chunk_size)
    IO.inspect(item: chunk, label: "CHUNK")
    IO.inspect(item: List.last(chunk), label: "LAST CHUNK")

    conn = conn
    |> put_resp_content_type("video/mp4")
    |> send_chunked(200)
    # |> put_status(200)
    # |> json(data)

    Enum.reduce_while(chunk, conn, fn (el, conn) ->
      case Plug.Conn.chunk(conn, el) do
        {:ok, conn} ->
          {:cont, conn}
        {:error, :closed} ->
          IO.inspect(item: el, label: "ERROR EL")
          {:halt, conn}
      end
    end)

    # conn
    # |> put_resp_content_type("video/mp4")
    # |> Stream.chunk_every(200)
    # |> Enum.map(&Base.decode64/1)
    # |> Enum.into(conn)
  end

  def chunk_entry(string, size \\ 5), do: chunk(string, size, [])

  defp chunk(<<>>, _size, acc), do: Enum.reverse(acc)
  defp chunk(string, size, acc) when byte_size(string) > size do
    <<c::size(size)-binary, rest::binary>> = string
    chunk(rest, size, [c | acc])
  end
  defp chunk(leftover, size, acc) do
    chunk(<<>>, size, [leftover | acc])
  end

  # def update(conn, %{"id" => id, "contents" => contents_params}) do
  #   contents = Content.get_contents!(id)

  #   with {:ok, %Contents{} = contents} <- Content.update_contents(contents, contents_params) do
  #     render(conn, "show.json", contents: contents)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    contents = Content.get_contents!(id)

    with {:ok, %Contents{}} <- Content.delete_contents(contents) do
      send_resp(conn, :no_content, "")
    end
  end
end
