defmodule BougBack.Accounts.UserTrophee do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "user_trophees" do

    belongs_to :user, BougBack.Accounts.User
    belongs_to :trophee, BougBack.Accounts.Trophee

    timestamps()
  end

  def changeset(user_trophee, attrs) do
    user_trophee
    |> cast(attrs, [:user_id, :trophee_id])
    |> validate_required([:user_id, :trophee_id])
  end
end
