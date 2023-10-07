defmodule BougBackWeb.Auth.SetUser do
  import Plug.Conn
  alias BougBackWeb.Auth.ErrorResponse
  alias BougBack.Accounts

  def init(_options) do

  end

  def call(conn, _options) do
    if conn.assigns[:user] do
      conn
    else
      IO.inspect(item: conn, label: "SETUSER CONN")
      user_id = get_session(conn, :user_id)

      if user_id == nil, do: raise ErrorResponse.Unauthorized

      user = Accounts.get_full_user(user_id)
      cond do
        user_id && user -> assign(conn, :user, user)
        true -> assign(conn, :user, nil)
      end
    end
  end

end
