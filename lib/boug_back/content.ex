defmodule BougBack.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias BougBack.Repo

  alias BougBack.Content.Fragment

  @doc """
  Returns the list of fragments.

  ## Examples

      iex> list_fragments()
      [%Fragment{}, ...]

  """
  def list_fragments do
    Repo.all(Fragment)
  end

  @doc """
  Gets a single fragment.

  Raises `Ecto.NoResultsError` if the Fragment does not exist.

  ## Examples

      iex> get_fragment!(123)
      %Fragment{}

      iex> get_fragment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fragment!(id), do: Repo.get!(Fragment, id)

  @doc """
  Creates a fragment.

  ## Examples

      iex> create_fragment(%{field: value})
      {:ok, %Fragment{}}

      iex> create_fragment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fragment(attrs \\ %{}) do
    %Fragment{}
    |> Fragment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fragment.

  ## Examples

      iex> update_fragment(fragment, %{field: new_value})
      {:ok, %Fragment{}}

      iex> update_fragment(fragment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fragment(%Fragment{} = fragment, attrs) do
    fragment
    |> Fragment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fragment.

  ## Examples

      iex> delete_fragment(fragment)
      {:ok, %Fragment{}}

      iex> delete_fragment(fragment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fragment(%Fragment{} = fragment) do
    Repo.delete(fragment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fragment changes.

  ## Examples

      iex> change_fragment(fragment)
      %Ecto.Changeset{data: %Fragment{}}

  """
  def change_fragment(%Fragment{} = fragment, attrs \\ %{}) do
    Fragment.changeset(fragment, attrs)
  end

  alias BougBack.Content.Heroe

  @doc """
  Returns the list of heroes.

  ## Examples

      iex> list_heroes()
      [%Heroe{}, ...]

  """
  def list_heroes do
    Repo.all(Heroe)
  end

  @doc """
  Gets a single heroe.

  Raises `Ecto.NoResultsError` if the Heroe does not exist.

  ## Examples

      iex> get_heroe!(123)
      %Heroe{}

      iex> get_heroe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_heroe!(id), do: Repo.get!(Heroe, id)

  @doc """
  Creates a heroe.

  ## Examples

      iex> create_heroe(%{field: value})
      {:ok, %Heroe{}}

      iex> create_heroe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_heroe(attrs \\ %{}) do
    %Heroe{}
    |> Heroe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a heroe.

  ## Examples

      iex> update_heroe(heroe, %{field: new_value})
      {:ok, %Heroe{}}

      iex> update_heroe(heroe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_heroe(%Heroe{} = heroe, attrs) do
    heroe
    |> Heroe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a heroe.

  ## Examples

      iex> delete_heroe(heroe)
      {:ok, %Heroe{}}

      iex> delete_heroe(heroe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_heroe(%Heroe{} = heroe) do
    Repo.delete(heroe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking heroe changes.

  ## Examples

      iex> change_heroe(heroe)
      %Ecto.Changeset{data: %Heroe{}}

  """
  def change_heroe(%Heroe{} = heroe, attrs \\ %{}) do
    Heroe.changeset(heroe, attrs)
  end

  alias BougBack.Content.Timeline

  @doc """
  Returns the list of timelines.

  ## Examples

      iex> list_timelines()
      [%Timeline{}, ...]

  """
  def list_timelines do
    Repo.all(Timeline)
  end

  @doc """
  Gets a single timeline.

  Raises `Ecto.NoResultsError` if the Timeline does not exist.

  ## Examples

      iex> get_timeline!(123)
      %Timeline{}

      iex> get_timeline!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timeline!(id), do: Repo.get!(Timeline, id)

  @doc """
  Creates a timeline.

  ## Examples

      iex> create_timeline(%{field: value})
      {:ok, %Timeline{}}

      iex> create_timeline(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timeline(attrs \\ %{}) do
    %Timeline{}
    |> Timeline.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeline.

  ## Examples

      iex> update_timeline(timeline, %{field: new_value})
      {:ok, %Timeline{}}

      iex> update_timeline(timeline, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timeline(%Timeline{} = timeline, attrs) do
    timeline
    |> Timeline.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a timeline.

  ## Examples

      iex> delete_timeline(timeline)
      {:ok, %Timeline{}}

      iex> delete_timeline(timeline)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timeline(%Timeline{} = timeline) do
    Repo.delete(timeline)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeline changes.

  ## Examples

      iex> change_timeline(timeline)
      %Ecto.Changeset{data: %Timeline{}}

  """
  def change_timeline(%Timeline{} = timeline, attrs \\ %{}) do
    Timeline.changeset(timeline, attrs)
  end
end
