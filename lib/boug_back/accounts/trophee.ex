defmodule BougBack.Accounts.Trophee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trophees" do
    field :date, :date
    field :entitle, :string
    field :picture, :string
    field :resume, :string
    many_to_many :users, BougBack.Accounts.User, join_through: BougBack.Accounts.UserTrophee

    timestamps()
  end

  @doc false
  def changeset(trophee, attrs) do
    trophee
    |> cast(attrs, [:entitle, :resume, :picture, :date])
    |> validate_required([:entitle, :resume, :picture, :date])
  end
end
