defmodule BougBack.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias BougBack.Repo

  alias BougBack.Content.Fragment
  alias BougBack.Content.Heroe
  alias BougBack.Content.Timeline
  alias BougBack.Content.Contents
  alias BougBack.Content.Miniature

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
  def get_fragment!(id) do
    frag = Repo.get!(Fragment, id)
    # |> Repo.preload([:contents, :miniature])

    frag
  end #, do: Repo.get!(Fragment, id)

  @spec get_sample_two_last_frags :: any
  @doc """
  Gets a sample of the two last fragments (title, id, type, miniature)

  ## Examples

      iex> get_sample_two_last_frags()
          %Fragment{}

      iex> get_sample_two_last_frags()
      ** (Ecto.NoResultsError)
  """
  def get_sample_two_last_frags do
    query = from(f in Fragment,
             order_by: [desc: f.id],
            #  select: %{title: f.title, id: f.id},
             limit: 2)

    result = Repo.all(query)
    |> Repo.preload([miniature: from(m in Miniature, select: %{id: m.id}), contents: from(c in Contents, select: %{id: c.id, type: c.type})])

    result
  end

  def get_sample_frags do
    # query = from(f in Fragment, select: %{title: f.title, id: f.id})
    query = from(f in Fragment, order_by: :number)
    Repo.all(query)
    |> Repo.preload([miniature: from(m in Miniature, select: %{id: m.id}), contents: from(c in Contents, select: %{id: c.id, type: c.type})])
  end

  def meta(id) do
    Repo.one(from f in Fragment, where: f.id == ^id, select: %{id: f.id, title: f.title, description: f.description, number: f.number})
  end

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

  @doc """
  Returns the list of contents.

  ## Examples

      iex> list_contents()
      [%Contents{}, ...]

  """
  def list_contents do
    Repo.all(Contents)
  end

  @doc """
  Gets a single contents.

  Raises `Ecto.NoResultsError` if the Contents does not exist.

  ## Examples

      iex> get_contents!(123)
      %Contents{}

      iex> get_contents!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contents!(id), do: Repo.get!(Contents, id)

  @doc """
  Creates a contents.

  ## Examples

      iex> create_contents(%{field: value})
      {:ok, %Contents{}}

      iex> create_contents(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contents(attrs \\ %{}) do
    %Contents{}
    |> Contents.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contents.

  ## Examples

      iex> update_contents(contents, %{field: new_value})
      {:ok, %Contents{}}

      iex> update_contents(contents, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contents(%Contents{} = contents, attrs) do
    contents
    |> Contents.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contents.

  ## Examples

      iex> delete_contents(contents)
      {:ok, %Contents{}}

      iex> delete_contents(contents)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contents(%Contents{} = contents) do
    Repo.delete(contents)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contents changes.

  ## Examples

      iex> change_contents(contents)
      %Ecto.Changeset{data: %Contents{}}

  """
  def change_contents(%Contents{} = contents, attrs \\ %{}) do
    Contents.changeset(contents, attrs)
  end

  @doc """
  Returns the list of miniatures.

  ## Examples

      iex> list_miniatures()
      [%Miniature{}, ...]

  """
  # def list_miniatures() do
  #   Repo.all(Miniature)
  # end

  def list_miniatures do
    Repo.all(Miniature)
  end

  @doc """
  Gets a single miniature.

  Raises `Ecto.NoResultsError` if the Miniature does not exist.

  ## Examples

      iex> get_miniature!(123)
      %Miniature{}

      iex> get_miniature!(456)
      ** (Ecto.NoResultsError)

  """
  def get_miniature!(id), do: Repo.get!(Miniature, id)

  @doc """
  Creates a miniature.

  ## Examples

      iex> create_miniature(%{field: value})
      {:ok, %Miniature{}}

      iex> create_miniature(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_miniature(attrs \\ %{}) do
    %Miniature{}
    |> Miniature.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a miniature.

  ## Examples

      iex> update_miniature(miniature, %{field: new_value})
      {:ok, %Miniature{}}

      iex> update_miniature(miniature, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_miniature(%Miniature{} = miniature, attrs) do
    miniature
    |> Miniature.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a miniature.

  ## Examples

      iex> delete_miniature(miniature)
      {:ok, %Miniature{}}

      iex> delete_miniature(miniature)
      {:error, %Ecto.Changeset{}}

  """
  def delete_miniature(%Miniature{} = miniature) do
    Repo.delete(miniature)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking miniature changes.

  ## Examples

      iex> change_miniature(miniature)
      %Ecto.Changeset{data: %Miniature{}}

  """
  def change_miniature(%Miniature{} = miniature, attrs \\ %{}) do
    Miniature.changeset(miniature, attrs)
  end
end
