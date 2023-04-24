defmodule BougBackWeb.UserControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.AccountsFixtures

  alias BougBack.Accounts.User

  @create_attrs %{
    about: "some about",
    age: 42,
    email: "some email",
    hash_password: "some hash_password",
    profil_img: "some profil_img",
    pseudo: "some pseudo",
    ville: "some ville"
  }
  @update_attrs %{
    about: "some updated about",
    age: 43,
    email: "some updated email",
    hash_password: "some updated hash_password",
    profil_img: "some updated profil_img",
    pseudo: "some updated pseudo",
    ville: "some updated ville"
  }
  @invalid_attrs %{about: nil, age: nil, email: nil, hash_password: nil, profil_img: nil, pseudo: nil, ville: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "about" => "some about",
               "age" => 42,
               "email" => "some email",
               "hash_password" => "some hash_password",
               "profil_img" => "some profil_img",
               "pseudo" => "some pseudo",
               "ville" => "some ville"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "about" => "some updated about",
               "age" => 43,
               "email" => "some updated email",
               "hash_password" => "some updated hash_password",
               "profil_img" => "some updated profil_img",
               "pseudo" => "some updated pseudo",
               "ville" => "some updated ville"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
