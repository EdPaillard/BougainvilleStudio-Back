defmodule BougBackWeb.FragmentView do
  use BougBackWeb, :view
  alias BougBackWeb.FragmentView

  def render("index.json", %{fragments: fragments}) do
    render_many(fragments, FragmentView, "sample_fragment.json")
  end

  def render("show.json", %{fragment: fragment}) do
    render_one(fragment, FragmentView, "fragment.json")
  end

  def render("fragment.json", %{fragment: fragment}) do
    %{
      id: fragment.id,
      title: fragment.title,
      description: fragment.description,
      number: fragment.number,
      contents: fragment.contents
    }
  end

  def render("meta.json", %{fragment: fragment}) do
    render_one(fragment, FragmentView, "full_fragment.json")
  end

  def render("full_fragment.json", %{fragment: fragment}) do
    %{
      id: fragment.id,
      title: fragment.title,
      description: fragment.description,
      # miniature: fragment.miniature,
      # contents: fragment.contents,
      number: fragment.number
    }
  end

  def render("sample_fragment.json", %{fragment: fragment}) do
    %{
      id: fragment.id,
      title: fragment.title,
      miniature: fragment.miniature,
      number: fragment.number,
      contents: fragment.contents
    }
  end

  def render("created_fragment.json", %{fragment: fragment}) do
    %{
      id: fragment.id,
      title: fragment.title,
      description: fragment.description,
      number: fragment.number
    }
  end
end
