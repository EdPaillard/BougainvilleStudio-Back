defmodule BougBack.Content.Fragment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fragments" do
    has_many :contents, BougBack.Content.Contents # [{"body":"fragment.mp4", "type":"mp4"}]
    has_one :miniature, BougBack.Content.Miniature
    # field :types, {:array, :string}
    field :description, :string
    field :title, :string
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(fragment, attrs) do
    fragment
    |> cast(attrs, [:title, :description, :number])
    |> validate_required([:title, :description, :number])
  end
end
