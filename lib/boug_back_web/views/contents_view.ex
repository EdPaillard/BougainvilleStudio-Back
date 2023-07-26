defmodule BougBackWeb.ContentsView do
  use BougBackWeb, :view
  alias BougBackWeb.ContentsView

  def render("index.json", %{contents: contents}) do
    %{data: render_many(contents, ContentsView, "contents.json")}
  end

  def render("show.json", %{contents: contents}) do
    %{data: render_one(contents, ContentsView, "contents.json")}
  end

  def render("contents.json", %{contents: contents}) do
    %{
      id: contents.id,
      body: contents.body
    }
  end
end
