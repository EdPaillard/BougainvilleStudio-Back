defmodule BougBackWeb.HeroeView do
  use BougBackWeb, :view
  alias BougBackWeb.HeroeView

  def render("index.json", %{heroes: heroes}) do
    %{data: render_many(heroes, HeroeView, "heroe.json")}
  end

  def render("show.json", %{heroe: heroe}) do
    %{data: render_one(heroe, HeroeView, "heroe.json")}
  end

  def render("heroe.json", %{heroe: heroe}) do
    %{
      id: heroe.id,
      background: heroe.background,
      pnj_picture: heroe.pnj_picture,
      pnj_sentence: heroe.pnj_sentence,
      options: heroe.options,
      save_scene: heroe.save_scene
    }
  end
end
