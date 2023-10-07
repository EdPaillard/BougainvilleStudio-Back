defmodule BougBack.Repo.Migrations.CreateTimelines do
  use Ecto.Migration

  def change do
    create table(:timelines) do
      add :title, :string
      add :content, {:array, :string}
      add :user_id, references(:users, type: :binary_id, on_delete: :nothing)

      timestamps()
    end
  end
end
