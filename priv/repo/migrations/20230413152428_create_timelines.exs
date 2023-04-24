defmodule BougBack.Repo.Migrations.CreateTimelines do
  use Ecto.Migration

  def change do
    create table(:timelines) do
      add :title, :string
      add :content, {:array, :string}

      timestamps()
    end
  end
end
