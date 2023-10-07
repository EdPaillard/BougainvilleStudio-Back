defmodule BougBack.Content.Timeline do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timelines" do
    field :content, {:array, :string}
    field :title, :string
    belongs_to :user, BougBack.Accounts.User, type: :binary_id
    many_to_many :fragments, BougBack.Content.Fragment, join_through: BougBack.Content.FragTimeline


    timestamps()
  end

  @doc false
  def changeset(timeline, attrs) do
    timeline
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
