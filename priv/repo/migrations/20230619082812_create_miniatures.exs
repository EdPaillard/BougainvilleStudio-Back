defmodule BougBack.Repo.Migrations.CreateMiniatures do
  use Ecto.Migration

  def change do
    create table(:miniatures) do
      add :mini, :binary
      add :fragment_id, references(:fragments, on_delete: :nothing)

      timestamps()
    end
  end
end
