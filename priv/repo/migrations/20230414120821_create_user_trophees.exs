defmodule BougBack.Repo.Migrations.CreateUserTrophees do
  use Ecto.Migration

  def change do
    create table(:user_trophees) do
      add :user_id, references(:users)
      add :trophee_id, references(:trophees)

      timestamps()
    end
  end
end
