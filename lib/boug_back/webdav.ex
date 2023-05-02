defmodule BougBack.Webdav do
  require Logger

@webdav_url System.get_env("WEBDAV_URL")
@webdav_user System.get_env("WEBDAV_USER")
@webdav_pass System.get_env("WEBDAV_PASS")

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
