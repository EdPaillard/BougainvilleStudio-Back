defmodule BougBack.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
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
    Repo.get!(User, id)
  end

  def get_full_user(id) do
    User
    |> where(id: ^id)
    |> preload([:trophees, :timelines, :heroe])
    |> Repo.one()
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
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
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

  alias BougBack.Accounts.Trophee

  @doc """
  Returns the list of trophees.

  ## Examples

      iex> list_trophees()
      [%Trophee{}, ...]

  """
  def list_trophees do
    Repo.all(Trophee)
  end

  @doc """
  Gets a single trophee.

  Raises `Ecto.NoResultsError` if the Trophee does not exist.

  ## Examples

      iex> get_trophee!(123)
      %Trophee{}

      iex> get_trophee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trophee!(id), do: Repo.get!(Trophee, id)

  @doc """
  Creates a trophee.

  ## Examples

      iex> create_trophee(%{field: value})
      {:ok, %Trophee{}}

      iex> create_trophee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trophee(attrs \\ %{}) do
    %Trophee{}
    |> Trophee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trophee.

  ## Examples

      iex> update_trophee(trophee, %{field: new_value})
      {:ok, %Trophee{}}

      iex> update_trophee(trophee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trophee(%Trophee{} = trophee, attrs) do
    trophee
    |> Trophee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a trophee.

  ## Examples

      iex> delete_trophee(trophee)
      {:ok, %Trophee{}}

      iex> delete_trophee(trophee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trophee(%Trophee{} = trophee) do
    Repo.delete(trophee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trophee changes.

  ## Examples

      iex> change_trophee(trophee)
      %Ecto.Changeset{data: %Trophee{}}

  """
  def change_trophee(%Trophee{} = trophee, attrs \\ %{}) do
    Trophee.changeset(trophee, attrs)
  end
end
