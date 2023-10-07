defmodule BougBackWeb.TrophyView do
  use BougBackWeb, :view
  alias BougBackWeb.TrophyView

  def render("index.json", %{trophies: trophies}) do
    %{data: render_many(trophies, TrophyView, "trophy.json")}
  end

  def render("show.json", %{trophy: trophy}) do
    %{data: render_one(trophy, TrophyView, "trophy.json")}
  end

  def render("trophy.json", %{trophy: trophy}) do
    %{
      id: trophy.id,
      entitle: trophy.entitle,
      resume: trophy.resume,
      picture: trophy.picture,
      date: trophy.date
    }
  end
end
