defmodule BougBack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:email, :pseudo, :id]}
  schema "users" do
    field :about, :string
    field :age, :integer
    field :email, :string
    field :password, :string
    field :profil_img, :string
    field :pseudo, :string
    field :ville, :string
    many_to_many :trophees, BougBack.Accounts.Trophee, join_through: BougBack.Accounts.UserTrophee, on_replace: :delete
    many_to_many :timelines, BougBack.Content.Timeline, join_through: BougBack.Content.UserTimeline, on_replace: :delete
    has_one :heroe, BougBack.Content.Heroe

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:pseudo, :about, :profil_img, :password, :age, :email, :ville])
    |> validate_required([:pseudo, :password, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Wrong mail format")
    |> validate_length(:email, max: 160)
    |> unique_constraint([:pseudo, :email])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

end
