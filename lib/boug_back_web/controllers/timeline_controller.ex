defmodule BougBackWeb.TimelineController do
  use BougBackWeb, :controller

  alias BougBack.Content
  alias BougBack.Content.Timeline

  action_fallback BougBackWeb.FallbackController

  def index(conn, _params) do
    timelines = Content.list_timelines()
    render(conn, "index.json", timelines: timelines)
  end

  def create(conn, %{"timeline" => timeline_params}) do
    with {:ok, %Timeline{} = timeline} <- Content.create_timeline(timeline_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timeline_path(conn, :show, timeline))
      |> render("show.json", timeline: timeline)
    end
  end

  def show(conn, %{"id" => id}) do
    timeline = Content.get_timeline!(id)
    render(conn, "show.json", timeline: timeline)
  end

  def update(conn, %{"id" => id, "timeline" => timeline_params}) do
    timeline = Content.get_timeline!(id)

    with {:ok, %Timeline{} = timeline} <- Content.update_timeline(timeline, timeline_params) do
      render(conn, "show.json", timeline: timeline)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeline = Content.get_timeline!(id)

    with {:ok, %Timeline{}} <- Content.delete_timeline(timeline) do
      send_resp(conn, :no_content, "")
    end
  end
end
