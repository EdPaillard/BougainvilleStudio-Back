defmodule BougBack.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BougBack.Content` context.
  """

  @doc """
  Generate a fragment.
  """
  def fragment_fixture(attrs \\ %{}) do
    {:ok, fragment} =
      attrs
      |> Enum.into(%{
        content: [],
        description: "some description",
        miniature: "some miniature",
        title: "some title"
      })
      |> BougBack.Content.create_fragment()

    fragment
  end

  @doc """
  Generate a heroe.
  """
  def heroe_fixture(attrs \\ %{}) do
    {:ok, heroe} =
      attrs
      |> Enum.into(%{
        background: "some background",
        options: "some options",
        pnj_picture: "some pnj_picture",
        pnj_sentence: "some pnj_sentence",
        save_scene: 42
      })
      |> BougBack.Content.create_heroe()

    heroe
  end

  @doc """
  Generate a timeline.
  """
  def timeline_fixture(attrs \\ %{}) do
    {:ok, timeline} =
      attrs
      |> Enum.into(%{
        content: [],
        title: "some title"
      })
      |> BougBack.Content.create_timeline()

    timeline
  end

  @doc """
  Generate a contents.
  """
  def contents_fixture(attrs \\ %{}) do
    {:ok, contents} =
      attrs
      |> Enum.into(%{
        body: "some body"
      })
      |> BougBack.Content.create_contents()

    contents
  end

  @doc """
  Generate a miniature.
  """
  def miniature_fixture(attrs \\ %{}) do
    {:ok, miniature} =
      attrs
      |> Enum.into(%{
        mini: "some mini"
      })
      |> BougBack.Content.create_miniature()

    miniature
  end
end
