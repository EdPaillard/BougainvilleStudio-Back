defmodule BougBackWeb.UserView do
  use BougBackWeb, :view
  alias BougBackWeb.{UserView, TrophyView, TimelineView, HeroeView}

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
      password: user.password,
      email: user.email,
      ville: user.ville
    }
  end

  def render("user_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      pseudo: user.pseudo,
      about: user.about,
      email: user.email,
      ville: user.ville,
      role: user.role,
      token: token
    }
  end

  def render("user_session.json", %{user: user, token: token}) do
    %{
      id: user.id,
      pseudo: user.pseudo,
      email: user.email,
      role: user.role,
      token: token
    }
  end

  def render("full_user.json", %{user: user}) do
    {:ok, userRole} = Jason.encode(user.role)
    IO.inspect(userRole)
    %{
      id: user.id,
      pseudo: user.pseudo,
      about: user.about,
      profil_img: user.profil_img,
      email: user.email,
      ville: user.ville,
      role: userRole, # render_one(user.role, RoleView, "role.json"),
      heroe: render_one(user.heroe, HeroeView, "heroe.json"),
      timelines: render(user.timelines, TimelineView, "timeline.json"),
      trophies: render(user.trophies, TrophyView, "trophy.json")
    }
  end
end
