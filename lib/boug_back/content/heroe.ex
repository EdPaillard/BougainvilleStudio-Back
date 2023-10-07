defmodule BougBack.Content.Heroe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "heroes" do
    field :background, :string
    field :options, {:map, :string}
    field :pnj_picture, :string
    field :pnj_sentence, :string
    field :save_scene, :integer
    belongs_to :user, BougBack.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(heroe, attrs) do
    heroe
    |> cast(attrs, [:background, :pnj_picture, :pnj_sentence, :options, :save_scene, :user_id])
    |> validate_required([:background, :pnj_picture, :pnj_sentence, :options, :save_scene])
  end
end
