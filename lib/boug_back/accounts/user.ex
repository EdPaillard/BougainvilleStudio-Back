defmodule BougBack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BougBack.Accounts.User

  alias Argon2

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:email, :pseudo, :id]}
  schema "users" do
    field :about, :string
    field :email, :string
    field :password, :string
    field :profil_img, :binary
    field :pseudo, :string
    field :ville, :string
    field :level, :integer
    field :exp, :integer
    many_to_many :trophies, BougBack.Accounts.Trophy, join_through: BougBack.Accounts.UserTrophy, on_replace: :delete
    has_many :timeline, BougBack.Content.Timeline
    has_one :heroe, BougBack.Content.Heroe
    has_one :role, BougBack.Accounts.Role

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:pseudo, :about, :profil_img, :password, :email, :ville, :level, :exp])
    |> validate_required([:password, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Wrong mail format")
    |> validate_length(:email, max: 160)
    |> unique_constraint([:pseudo, :email])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  def changeset_update_trophies(%User{} = user, trophies) do
    user
    |> cast(%{}, [:pseudo, :about, :profil_img, :password, :email, :ville, :level, :exp])
    |> put_assoc(:trophies, List.flatten([trophies | user.trophies]))
  end

  def update_user(user, attrs) do
    user
    |> cast(attrs, [:pseudo, :about, :profil_img, :password, :email, :ville, :level, :exp])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Wrong mail format")
    |> validate_length(:email, max: 160)
    |> unique_constraint([:pseudo, :email])
    |> put_password_hash()
  end

end
