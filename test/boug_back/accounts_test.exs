defmodule BougBack.AccountsTest do
  use BougBack.DataCase

  alias BougBack.Accounts

  describe "users" do
    alias BougBack.Accounts.User

    import BougBack.AccountsFixtures

    @invalid_attrs %{about: nil, age: nil, email: nil, hash_password: nil, profil_img: nil, pseudo: nil, ville: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{about: "some about", age: 42, email: "some email", hash_password: "some hash_password", profil_img: "some profil_img", pseudo: "some pseudo", ville: "some ville"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.about == "some about"
      assert user.age == 42
      assert user.email == "some email"
      assert user.hash_password == "some hash_password"
      assert user.profil_img == "some profil_img"
      assert user.pseudo == "some pseudo"
      assert user.ville == "some ville"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{about: "some updated about", age: 43, email: "some updated email", hash_password: "some updated hash_password", profil_img: "some updated profil_img", pseudo: "some updated pseudo", ville: "some updated ville"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.about == "some updated about"
      assert user.age == 43
      assert user.email == "some updated email"
      assert user.hash_password == "some updated hash_password"
      assert user.profil_img == "some updated profil_img"
      assert user.pseudo == "some updated pseudo"
      assert user.ville == "some updated ville"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "trophees" do
    alias BougBack.Accounts.Trophee

    import BougBack.AccountsFixtures

    @invalid_attrs %{date: nil, entitle: nil, picture: nil, resume: nil}

    test "list_trophees/0 returns all trophees" do
      trophee = trophee_fixture()
      assert Accounts.list_trophees() == [trophee]
    end

    test "get_trophee!/1 returns the trophee with given id" do
      trophee = trophee_fixture()
      assert Accounts.get_trophee!(trophee.id) == trophee
    end

    test "create_trophee/1 with valid data creates a trophee" do
      valid_attrs = %{date: ~D[2023-04-12], entitle: "some entitle", picture: "some picture", resume: "some resume"}

      assert {:ok, %Trophee{} = trophee} = Accounts.create_trophee(valid_attrs)
      assert trophee.date == ~D[2023-04-12]
      assert trophee.entitle == "some entitle"
      assert trophee.picture == "some picture"
      assert trophee.resume == "some resume"
    end

    test "create_trophee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_trophee(@invalid_attrs)
    end

    test "update_trophee/2 with valid data updates the trophee" do
      trophee = trophee_fixture()
      update_attrs = %{date: ~D[2023-04-13], entitle: "some updated entitle", picture: "some updated picture", resume: "some updated resume"}

      assert {:ok, %Trophee{} = trophee} = Accounts.update_trophee(trophee, update_attrs)
      assert trophee.date == ~D[2023-04-13]
      assert trophee.entitle == "some updated entitle"
      assert trophee.picture == "some updated picture"
      assert trophee.resume == "some updated resume"
    end

    test "update_trophee/2 with invalid data returns error changeset" do
      trophee = trophee_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_trophee(trophee, @invalid_attrs)
      assert trophee == Accounts.get_trophee!(trophee.id)
    end

    test "delete_trophee/1 deletes the trophee" do
      trophee = trophee_fixture()
      assert {:ok, %Trophee{}} = Accounts.delete_trophee(trophee)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_trophee!(trophee.id) end
    end

    test "change_trophee/1 returns a trophee changeset" do
      trophee = trophee_fixture()
      assert %Ecto.Changeset{} = Accounts.change_trophee(trophee)
    end
  end
end
