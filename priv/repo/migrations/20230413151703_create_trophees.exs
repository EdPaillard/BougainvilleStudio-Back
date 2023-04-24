defmodule BougBack.Repo.Migrations.CreateTrophees do
  use Ecto.Migration

  def change do
    create table(:trophees) do
      add :entitle, :string
      add :resume, :string
      add :picture, :string
      add :date, :date

      timestamps()
    end
  end
end
