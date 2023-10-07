defmodule BougBack.Repo.Migrations.CreateFragTimelines do
  use Ecto.Migration

  def change do
    create table(:frag_timelines) do
      add :fragment_id, references(:fragments)
      add :timeline_id, references(:timelines)

      timestamps()
    end
  end
end
