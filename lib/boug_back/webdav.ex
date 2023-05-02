defmodule BougBack.Webdav do
  require Logger

@webdav_url System.get_env("WEBDAV_URL")
@webdav_user System.get_env("WEBDAV_USER")
@webdav_pass System.get_env("WEBDAV_PASS")

def upload_file(file, path) do
  # folder_arr = path["folder"]
  # file_path_arr = path["file"]
  headers = ["Authorization": "Basic #{Base.encode64("#{@webdav_user}:#{@webdav_pass}")}"]

  arrays_frag = Enum.zip(file, path)

  upload = Enum.map(arrays_frag, fn {content, path_elem} ->
    with {:ok, %HTTPoison.Response{status_code: 201}} <- HTTPoison.put("#{@webdav_url}/#{path_elem["folder"]}", "", headers),
         {:ok, %HTTPoison.Response{status_code: 201, body: body}} <- HTTPoison.put("#{@webdav_url}/#{path_elem["folder"]}/#{path_elem["file"]}", content, headers) do
      Logger.info("File uploaded successfully: #{body}")
      {:ok, body}
    else
      {:error, error} ->
        Logger.info("A problem occurred... #{error}")
        {:error, error}
    end
  end)
  check = Enum.any?(upload, fn element ->
    Map.has_key?(element, :error)
  end)
  case check do
    true ->
      filtered =
        Enum.filter(upload, fn element -> Map.has_key?(element, :error) end)
        |> Enum.map(fn {:error, error} -> error end)
      {:error, filtered}
    false ->
      {:ok, "File uploaded successfully"}
  end
end

def download_file(file_path) do
  headers = ["Authorization": "Basic #{Base.encode64("#{@webdav_user}:#{@webdav_pass}")}"]
  with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- HTTPoison.get("#{@webdav_url}/#{file_path}", headers) do
    File.write(file_path, body)
    body
  else
    {:error, error} ->
      Logger.info("A problem occurred... #{error}")
      {:error, error}
  end
end

end
