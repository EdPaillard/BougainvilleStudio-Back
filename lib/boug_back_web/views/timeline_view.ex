defmodule BougBackWeb.TimelineView do
  use BougBackWeb, :view
  alias BougBackWeb.TimelineView

  def render("index.json", %{timelines: timelines}) do
    %{data: render_many(timelines, TimelineView, "timeline.json")}
  end

  def render("show.json", %{timeline: timeline}) do
    %{data: render_one(timeline, TimelineView, "timeline.json")}
  end

  def render("timeline.json", %{timeline: timeline}) do
    %{
      id: timeline.id,
      title: timeline.title,
      content: timeline.content
    }
  end
end
