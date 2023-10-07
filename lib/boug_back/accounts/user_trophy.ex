defmodule BougBack.Accounts.UserTrophy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "user_trophies" do

    belongs_to :user, BougBack.Accounts.User, type: :binary_id
    belongs_to :trophy, BougBack.Accounts.Trophy

    timestamps()
  end

  def changeset(user_trophy, attrs) do
    user_trophy
    |> cast(attrs, [:user_id, :trophy_id])
    |> validate_required([:user_id, :trophy_id])
  end
end
