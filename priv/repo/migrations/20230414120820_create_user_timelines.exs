defmodule BougBack.Repo.Migrations.CreateUserTimelines do
  use Ecto.Migration

  def change do
    create table(:user_timelines) do
      add :user_id, references(:users)
      add :timeline_id, references(:timelines)

      timestamps()
    end
  end
end
