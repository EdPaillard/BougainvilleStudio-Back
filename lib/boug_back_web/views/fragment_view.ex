defmodule BougBackWeb.FragmentView do
  use BougBackWeb, :view
  alias BougBackWeb.FragmentView

  def render("index.json", %{fragments: fragments}) do
    %{data: render_many(fragments, FragmentView, "fragment.json")}
  end

  def render("show.json", %{fragment: fragment}) do
    %{data: render_one(fragment, FragmentView, "fragment.json")}
  end

  def render("fragment.json", %{fragment: fragment}) do
    %{
      id: fragment.id,
      title: fragment.title,
      description: fragment.description,
      miniature: fragment.miniature,
      content: fragment.content
    }
  end
end
