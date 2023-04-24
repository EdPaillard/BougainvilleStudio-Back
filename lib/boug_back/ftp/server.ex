defmodule BougBack.Ftp.Server do
  @ftp_url System.get_env("FTP_URL")
  @ftp_user System.get_env("FTP_USER")
  @ftp_pass System.get_env("FTP_PASS")

  def upload_file(file) do
    {:ok, conn} = Sftp.connect([host: @ftp_url, user: @ftp_user, password: @ftp_pass])
    stream = File.stream!(file)
    |> Stream.into(Sftp.stream!(conn, "#{file}"))
    |> Stream.run

    {:ok, stream}
  end

  def download_file(path) do
    {:ok, conn} = Sftp.connect([host: @ftp_url, user: @ftp_user, password: @ftp_pass])
    stream = Sftp.stream!(conn, path)
    |> Stream.into(File.stream!("#{path}"))
    |> Stream.run

    {:ok, stream}
  end

end
