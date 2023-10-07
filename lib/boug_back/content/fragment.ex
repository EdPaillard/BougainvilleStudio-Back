defmodule BougBack.Content.Fragment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fragments" do
    has_many :contents, BougBack.Content.Contents
    has_one :miniature, BougBack.Content.Miniature
    field :description, :string
    field :title, :string
    field :number, :integer
    many_to_many :timelines, BougBack.Content.Timeline, join_through: BougBack.Content.FragTimeline


    timestamps()
  end

  @doc false
  def changeset(fragment, attrs) do
    fragment
    |> cast(attrs, [:title, :description, :number])
    |> validate_required([:title, :description, :number])
  end
end
