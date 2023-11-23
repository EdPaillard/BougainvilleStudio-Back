defmodule BougBack.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :user]}
  schema "roles" do
    field :admin, :boolean, default: false
    field :moderator, :boolean, default: false
    belongs_to :user, BougBack.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:admin, :moderator, :user_id])
    |> validate_required([:admin, :moderator, :user_id])
  end
end
