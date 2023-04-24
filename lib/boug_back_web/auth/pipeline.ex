defmodule BougBackWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :boug_back,
  module: BougBackWeb.Auth.Guardian,
  error_handler: BougBackWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true

end
