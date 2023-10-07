defmodule BougBack.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BougBack.Accounts
  alias BougBack.Accounts.Trophy
  alias BougBack.Repo

  alias BougBack.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> where(id: ^id)
    |> preload([:role])
    |> Repo.one()
  end

  def get_session_user(id) do
    Repo.one(from u in User, where: u.id == ^id, select: %{id: u.id, email: u.email, pseudo: u.pseudo})
  end

  def get_full_user(id) do
    User
    |> where(id: ^id)
    |> preload([:trophies, :timeline, :heroe, :role])
    |> Repo.one()
  end

  def upsert_user_trophy(user, trophy_id) do
    trophies =
      Trophy
      |> where(id: ^trophy_id)
      |> Repo.one()

    with {:ok, _struct} <-
        user
        |> User.changeset_update_trophies(trophies)
        |> Repo.update() do
      {:ok, Accounts.get_user!(user.id)}
    else
      error ->
        error
    end
  end
  @doc """
  Gets a single user.any()

  Returns 'nil' if the User does not exist

  ## Examples

    iex> get_user_by_email(test@email.com)
    %User{}

    iex> get_user_by_email(no_user@email.com)
    nil
  """

  def get_user_by_email(email) do
    User
    |> where(email: ^email)
    |> preload([:trophies, :timeline, :heroe, :role])
    |> Repo.one()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec authenticate_user(any, any) :: {:ok, User.t()} | {:error, :invalid_credentials}
  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email
    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}
      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(user, attrs) do
    IO.inspect(item: user, label: "UPDATE USER")
    IO.inspect(item: attrs, label: "UPDATE ATTRS")
    user
    |> User.update_user(attrs)
    |> Repo.update()
  end

  def get_profil_pic(id) do
    Repo.one(from u in User, where: u.id == ^id, select: %{profil_img: u.profil_img})
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias BougBack.Accounts.Trophy

  @doc """
  Returns the list of trophies.

  ## Examples

      iex> list_trophies()
      [%Trophy{}, ...]

  """
  def list_trophies do
    Repo.all(Trophy)
  end

  @doc """
  Gets a single trophy.

  Raises `Ecto.NoResultsError` if the Trophy does not exist.

  ## Examples

      iex> get_trophy!(123)
      %Trophy{}

      iex> get_trophy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trophy!(id), do: Repo.get!(Trophy, id)

  @doc """
  Creates a trophy.

  ## Examples

      iex> create_trophy(%{field: value})
      {:ok, %Trophy{}}

      iex> create_trophy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trophy(attrs \\ %{}) do
    %Trophy{}
    |> Trophy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trophy.

  ## Examples

      iex> update_trophy(trophy, %{field: new_value})
      {:ok, %Trophy{}}

      iex> update_trophy(trophy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trophy(%Trophy{} = trophy, attrs) do
    trophy
    |> Trophy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a trophy.

  ## Examples

      iex> delete_trophy(trophy)
      {:ok, %Trophy{}}

      iex> delete_trophy(trophy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trophy(%Trophy{} = trophy) do
    Repo.delete(trophy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trophy changes.

  ## Examples

      iex> change_trophy(trophy)
      %Ecto.Changeset{data: %Trophy{}}

  """
  def change_trophy(%Trophy{} = trophy, attrs \\ %{}) do
    Trophy.changeset(trophy, attrs)
  end

  alias BougBack.Accounts.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end
end
