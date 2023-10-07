defmodule BougBack.Repo.Migrations.CreateTrophies do
  use Ecto.Migration

  def change do
    create table(:trophies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :entitle, :string
      add :resume, :string
      add :picture, :binary
      add :date, :date
      add :exp, :integer

      timestamps()
    end
  end
end
