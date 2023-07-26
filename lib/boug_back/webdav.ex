defmodule BougBack.Webdav do
  require Logger

@webdav_url System.get_env("WEBDAV_URL")
@webdav_user System.get_env("WEBDAV_USER")
@webdav_pass System.get_env("WEBDAV_PASS")

def download_file(file_path) do
  IO.inspect(item: file_path, label: "FILE PATH")
  headers = ["Authorization": "Basic #{Base.encode64("#{@webdav_user}:#{@webdav_pass}")}"]
  with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- HTTPoison.get("http://#{@webdav_url}:8080/#{file_path}", headers) do
    File.write(file_path, body)
    Base.encode64(body)
  else
    {:ok, %HTTPoison.Response{status_code: 403, body: body}} ->
      Logger.info("A problem occurred...")
      {:error, body}
  end
end

end
