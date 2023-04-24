defmodule BougBackWeb.TimelineControllerTest do
  use BougBackWeb.ConnCase

  import BougBack.ContentFixtures

  alias BougBack.Content.Timeline

  @create_attrs %{
    content: [],
    title: "some title"
  }
  @update_attrs %{
    content: [],
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timelines", %{conn: conn} do
      conn = get(conn, Routes.timeline_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timeline" do
    test "renders timeline when data is valid", %{conn: conn} do
      conn = post(conn, Routes.timeline_path(conn, :create), timeline: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.timeline_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => [],
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.timeline_path(conn, :create), timeline: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timeline" do
    setup [:create_timeline]

    test "renders timeline when data is valid", %{conn: conn, timeline: %Timeline{id: id} = timeline} do
      conn = put(conn, Routes.timeline_path(conn, :update, timeline), timeline: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.timeline_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => [],
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, timeline: timeline} do
      conn = put(conn, Routes.timeline_path(conn, :update, timeline), timeline: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timeline" do
    setup [:create_timeline]

    test "deletes chosen timeline", %{conn: conn, timeline: timeline} do
      conn = delete(conn, Routes.timeline_path(conn, :delete, timeline))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.timeline_path(conn, :show, timeline))
      end
    end
  end

  defp create_timeline(_) do
    timeline = timeline_fixture()
    %{timeline: timeline}
  end
end
