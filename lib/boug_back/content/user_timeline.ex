# defmodule BougBack.Content.UserTimeline do
#   use Ecto.Schema
#   import Ecto.Changeset

#   @primary_key false
#   @derive {Jason.Encoder, except: [:__meta__]}
#   schema "user_timelines" do

#     belongs_to :user, BougBack.Accounts.User
#     belongs_to :timeline, BougBack.Content.Timeline

#     timestamps()
#   end

#   def changeset(user_timeline, attrs) do
#     user_timeline
#     |> cast(attrs, [:user_id, :timeline_id])
#     |> validate_required([:user_id, :timeline_id])
#   end
# end
