defmodule BougBack.Content.Fragment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fragments" do
    field :content, {:array, :map}
    field :description, :string
    field :miniature, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(fragment, attrs) do
    fragment
    |> cast(attrs, [:title, :description, :miniature, :content])
    |> validate_required([:title, :description, :miniature, :content])
  end
end
