defmodule BougBack.Content.FragTimeline do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "frag_timelines" do

    belongs_to :fragment, BougBack.Content.Fragment
    belongs_to :timeline, BougBack.Content.Timeline

    timestamps()
  end

  def changeset(user_timeline, attrs) do
    user_timeline
    |> cast(attrs, [:fragment_id, :timeline_id])
    |> validate_required([:fragment_id, :timeline_id])
  end
end
