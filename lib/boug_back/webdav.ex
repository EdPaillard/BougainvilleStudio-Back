defmodule BougBack.Webdav do
  require Logger

@webdav_url System.get_env("WEBDAV_URL")

def upload_file(file) do
  headers = [
    {"Content-Type", "text/plain"}
  ]

  with {:ok, %HTTPoison.Response{status_code: 201, body: body}} <- HTTPoison.put("162.19.66.30", file, headers) do
    Logger.info("File uploaded successfully: #{body}")
    {:ok, body}
  else
    {:error, error} ->
      Logger.info("A problem occurred... #{error}")
      {:error, error}
  end
end

def download_file(file_path) do
  headers = [
    {"Content-Type", "text/plain"}
  ]
  with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- HTTPoison.get("162.19.66.30", headers, hackney: [ssl: [{:verify, :verify_none}]], follow_redirect: true) do
    File.write(file_path, body)
    {:ok, body}
  else
    {:error, error} ->
      Logger.info("A problem occurred... #{error}")
      {:error, error}
  end
end

end
