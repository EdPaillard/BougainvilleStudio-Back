defmodule BougBackWeb.MiniatureControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.ContentFixtures

  alias BougBack.Content.Miniature

  @create_attrs %{
    mini: "some mini"
  }
  @update_attrs %{
    mini: "some updated mini"
  }
  @invalid_attrs %{mini: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all miniaturess", %{conn: conn} do
      conn = get(conn, Routes.miniature_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create miniature" do
    test "renders miniature when data is valid", %{conn: conn} do
      conn = post(conn, Routes.miniature_path(conn, :create), miniature: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.miniature_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "mini" => "some mini"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.miniature_path(conn, :create), miniature: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update miniature" do
    setup [:create_miniature]

    test "renders miniature when data is valid", %{conn: conn, miniature: %Miniature{id: id} = miniature} do
      conn = put(conn, Routes.miniature_path(conn, :update, miniature), miniature: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.miniature_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "mini" => "some updated mini"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, miniature: miniature} do
      conn = put(conn, Routes.miniature_path(conn, :update, miniature), miniature: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete miniature" do
    setup [:create_miniature]

    test "deletes chosen miniature", %{conn: conn, miniature: miniature} do
      conn = delete(conn, Routes.miniature_path(conn, :delete, miniature))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.miniature_path(conn, :show, miniature))
      end
    end
  end

  defp create_miniature(_) do
    miniature = miniature_fixture()
    %{miniature: miniature}
  end
end
