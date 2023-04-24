defmodule BougBack.Repo do
  use Ecto.Repo,
    otp_app: :boug_back,
    adapter: Ecto.Adapters.Postgres
end
