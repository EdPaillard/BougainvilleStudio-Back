defmodule BougBack.Content.Miniature do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:mini]}
  schema "miniatures" do
    field :mini, :binary
    belongs_to :fragment, BougBack.Content.Fragment

    timestamps()
  end

  @doc false
  def changeset(miniature, attrs) do
    miniature
    |> cast(attrs, [:mini, :fragment_id])
    |> validate_required([:mini, :fragment_id])
  end
end
