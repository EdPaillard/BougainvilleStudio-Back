defmodule BougBack.Accounts.Trophy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trophies" do
    field :date, :date
    field :entitle, :string
    field :picture, :binary
    field :resume, :string
    field :exp, :integer
    many_to_many :users, BougBack.Accounts.User, join_through: BougBack.Accounts.UserTrophy

    timestamps()
  end

  @doc false
  def changeset(trophy, attrs) do
    trophy
    |> cast(attrs, [:entitle, :resume, :picture, :date, :exp])
    |> validate_required([:entitle, :resume, :picture, :date, :exp])
  end
end
