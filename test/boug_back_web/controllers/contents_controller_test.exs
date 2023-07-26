defmodule BougBackWeb.ContentsControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.ContentFixtures

  alias BougBack.Content.Contents

  @create_attrs %{
    body: "some body"
  }
  @update_attrs %{
    body: "some updated body"
  }
  @invalid_attrs %{body: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contents", %{conn: conn} do
      conn = get(conn, Routes.contents_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contents" do
    test "renders contents when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contents_path(conn, :create), contents: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.contents_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "body" => "some body"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contents_path(conn, :create), contents: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contents" do
    setup [:create_contents]

    test "renders contents when data is valid", %{conn: conn, contents: %Contents{id: id} = contents} do
      conn = put(conn, Routes.contents_path(conn, :update, contents), contents: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.contents_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "body" => "some updated body"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, contents: contents} do
      conn = put(conn, Routes.contents_path(conn, :update, contents), contents: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contents" do
    setup [:create_contents]

    test "deletes chosen contents", %{conn: conn, contents: contents} do
      conn = delete(conn, Routes.contents_path(conn, :delete, contents))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.contents_path(conn, :show, contents))
      end
    end
  end

  defp create_contents(_) do
    contents = contents_fixture()
    %{contents: contents}
  end
end
