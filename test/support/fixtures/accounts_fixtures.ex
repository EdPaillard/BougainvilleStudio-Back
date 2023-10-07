defmodule BougBack.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BougBack.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        about: "some about",
        age: 42,
        email: "some email",
        hash_password: "some hash_password",
        profil_img: "some profil_img",
        pseudo: "some pseudo",
        ville: "some ville"
      })
      |> BougBack.Accounts.create_user()

    user
  end

  @doc """
  Generate a trophy.
  """
  def trophee_fixture(attrs \\ %{}) do
    {:ok, trophee} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-04-12],
        entitle: "some entitle",
        picture: "some picture",
        resume: "some resume"
      })
      |> BougBack.Accounts.create_trophy()

    trophee
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        admin: true,
        moderator: true
      })
      |> BougBack.Accounts.create_role()

    role
  end
end
