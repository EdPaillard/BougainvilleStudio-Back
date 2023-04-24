defmodule BougBackWeb.TropheeView do
  use BougBackWeb, :view
  alias BougBackWeb.TropheeView

  def render("index.json", %{trophees: trophees}) do
    %{data: render_many(trophees, TropheeView, "trophee.json")}
  end

  def render("show.json", %{trophee: trophee}) do
    %{data: render_one(trophee, TropheeView, "trophee.json")}
  end

  def render("trophee.json", %{trophee: trophee}) do
    %{
      id: trophee.id,
      entitle: trophee.entitle,
      resume: trophee.resume,
      picture: trophee.picture,
      date: trophee.date
    }
  end
end
