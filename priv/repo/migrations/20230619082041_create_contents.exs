defmodule BougBack.Repo.Migrations.CreateContents do
  use Ecto.Migration

  def change do
    create table(:contents) do
      add :body, :binary
      add :type, :string
      add :fragment_id, references(:fragments, on_delete: :nothing)

      timestamps()
    end
  end
end
