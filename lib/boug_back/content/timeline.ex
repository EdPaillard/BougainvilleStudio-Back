defmodule BougBack.Content.Timeline do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timelines" do
    field :content, {:array, :string}
    field :title, :string
    many_to_many :users, BougBack.Accounts.User, join_through: BougBack.Content.UserTimeline


    timestamps()
  end

  @doc false
  def changeset(timeline, attrs) do
    timeline
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
