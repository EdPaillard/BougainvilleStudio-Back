defmodule BougBack.Content.Contents do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:body, :type]}
  schema "contents" do
    field :body, :binary
    field :type, :string
    belongs_to :fragment, BougBack.Content.Fragment

    timestamps()
  end

  @doc false
  def changeset(contents, attrs) do
    contents
    |> cast(attrs, [:body, :type, :fragment_id])
    |> validate_required([:type, :fragment_id])
  end
end
