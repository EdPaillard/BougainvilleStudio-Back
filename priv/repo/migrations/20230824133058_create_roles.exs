defmodule BougBack.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :admin, :boolean, default: false, null: false
      add :moderator, :boolean, default: false, null: false
      add :user_id, references(:users, type: :binary_id, on_delete: :nothing)

      timestamps()
    end
  end
end
