defmodule BougBackWeb.TropheeControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.AccountsFixtures

  alias BougBack.Accounts.Trophee

  @create_attrs %{
    date: ~D[2023-04-12],
    entitle: "some entitle",
    picture: "some picture",
    resume: "some resume"
  }
  @update_attrs %{
    date: ~D[2023-04-13],
    entitle: "some updated entitle",
    picture: "some updated picture",
    resume: "some updated resume"
  }
  @invalid_attrs %{date: nil, entitle: nil, picture: nil, resume: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trophees", %{conn: conn} do
      conn = get(conn, Routes.trophee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trophee" do
    test "renders trophee when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trophee_path(conn, :create), trophee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trophee_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2023-04-12",
               "entitle" => "some entitle",
               "picture" => "some picture",
               "resume" => "some resume"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trophee_path(conn, :create), trophee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trophee" do
    setup [:create_trophee]

    test "renders trophee when data is valid", %{conn: conn, trophee: %Trophee{id: id} = trophee} do
      conn = put(conn, Routes.trophee_path(conn, :update, trophee), trophee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trophee_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2023-04-13",
               "entitle" => "some updated entitle",
               "picture" => "some updated picture",
               "resume" => "some updated resume"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trophee: trophee} do
      conn = put(conn, Routes.trophee_path(conn, :update, trophee), trophee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trophee" do
    setup [:create_trophee]

    test "deletes chosen trophee", %{conn: conn, trophee: trophee} do
      conn = delete(conn, Routes.trophee_path(conn, :delete, trophee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trophee_path(conn, :show, trophee))
      end
    end
  end

  defp create_trophee(_) do
    trophee = trophee_fixture()
    %{trophee: trophee}
  end
end
