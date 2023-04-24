defmodule BougBackWeb.HeroeControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.ContentFixtures

  alias BougBack.Content.Heroe

  @create_attrs %{
    background: "some background",
    options: "some options",
    pnj_picture: "some pnj_picture",
    pnj_sentence: "some pnj_sentence",
    save_scene: 42
  }
  @update_attrs %{
    background: "some updated background",
    options: "some updated options",
    pnj_picture: "some updated pnj_picture",
    pnj_sentence: "some updated pnj_sentence",
    save_scene: 43
  }
  @invalid_attrs %{background: nil, options: nil, pnj_picture: nil, pnj_sentence: nil, save_scene: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all heroes", %{conn: conn} do
      conn = get(conn, Routes.heroe_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create heroe" do
    test "renders heroe when data is valid", %{conn: conn} do
      conn = post(conn, Routes.heroe_path(conn, :create), heroe: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.heroe_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "background" => "some background",
               "options" => "some options",
               "pnj_picture" => "some pnj_picture",
               "pnj_sentence" => "some pnj_sentence",
               "save_scene" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.heroe_path(conn, :create), heroe: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update heroe" do
    setup [:create_heroe]

    test "renders heroe when data is valid", %{conn: conn, heroe: %Heroe{id: id} = heroe} do
      conn = put(conn, Routes.heroe_path(conn, :update, heroe), heroe: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.heroe_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "background" => "some updated background",
               "options" => "some updated options",
               "pnj_picture" => "some updated pnj_picture",
               "pnj_sentence" => "some updated pnj_sentence",
               "save_scene" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, heroe: heroe} do
      conn = put(conn, Routes.heroe_path(conn, :update, heroe), heroe: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete heroe" do
    setup [:create_heroe]

    test "deletes chosen heroe", %{conn: conn, heroe: heroe} do
      conn = delete(conn, Routes.heroe_path(conn, :delete, heroe))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.heroe_path(conn, :show, heroe))
      end
    end
  end

  defp create_heroe(_) do
    heroe = heroe_fixture()
    %{heroe: heroe}
  end
end
