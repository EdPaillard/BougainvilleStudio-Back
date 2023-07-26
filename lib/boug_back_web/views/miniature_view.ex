defmodule BougBackWeb.MiniatureView do
  use BougBackWeb, :view
  alias BougBackWeb.MiniatureView

  def render("index.json", %{miniatures: miniatures}) do
    %{data: render_many(miniatures, MiniatureView, "miniature.json")}
  end

  def render("show.json", %{miniature: miniature}) do
    %{data: render_one(miniature, MiniatureView, "miniature.json")}
  end

  def render("miniature.json", %{miniature: miniature}) do
    %{
      id: miniature.id,
      mini: miniature.mini
    }
  end
end
