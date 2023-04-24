defmodule BougBackWeb.FragmentControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.ContentFixtures

  alias BougBack.Content.Fragment

  @create_attrs %{
    content: [],
    description: "some description",
    miniature: "some miniature",
    title: "some title"
  }
  @update_attrs %{
    content: [],
    description: "some updated description",
    miniature: "some updated miniature",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, description: nil, miniature: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all fragments", %{conn: conn} do
      conn = get(conn, Routes.fragment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create fragment" do
    test "renders fragment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fragment_path(conn, :create), fragment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.fragment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => [],
               "description" => "some description",
               "miniature" => "some miniature",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fragment_path(conn, :create), fragment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update fragment" do
    setup [:create_fragment]

    test "renders fragment when data is valid", %{conn: conn, fragment: %Fragment{id: id} = fragment} do
      conn = put(conn, Routes.fragment_path(conn, :update, fragment), fragment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.fragment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => [],
               "description" => "some updated description",
               "miniature" => "some updated miniature",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, fragment: fragment} do
      conn = put(conn, Routes.fragment_path(conn, :update, fragment), fragment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete fragment" do
    setup [:create_fragment]

    test "deletes chosen fragment", %{conn: conn, fragment: fragment} do
      conn = delete(conn, Routes.fragment_path(conn, :delete, fragment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.fragment_path(conn, :show, fragment))
      end
    end
  end

  defp create_fragment(_) do
    fragment = fragment_fixture()
    %{fragment: fragment}
  end
end
