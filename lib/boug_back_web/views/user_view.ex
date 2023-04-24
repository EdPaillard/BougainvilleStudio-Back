defmodule BougBackWeb.UserView do
  use BougBackWeb, :view
  alias BougBackWeb.{UserView, TropheeView, TimelineView, HeroeView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      pseudo: user.pseudo,
      about: user.about,
      profil_img: user.profil_img,
      password: user.password,
      age: user.age,
      email: user.email,
      ville: user.ville
    }
  end

  def render("user_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end

  def render("full_user.json", %{user: user}) do
    %{
      id: user.id,
      pseudo: user.pseudo,
      about: user.about,
      profil_img: user.profil_img,
      age: user.age,
      email: user.email,
      ville: user.ville,
      heroe: render_one(user.heroe, HeroeView, "heroe.json"),
      timelines: render(user.timelines, TimelineView, "timeline.json"),
      trophees: render(user.trophees, TropheeView, "trophee.json")
    }
  end
end
