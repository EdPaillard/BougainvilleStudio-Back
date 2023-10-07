defmodule BougBack.Repo.Migrations.CreateMiniatures do
  use Ecto.Migration

  def change do
    create table(:miniatures) do
      add :mini, :binary
      add :bg_color, {:array, :integer}
      add :fragment_id, references(:fragments, on_delete: :nothing)

      timestamps()
    end
  end
end
