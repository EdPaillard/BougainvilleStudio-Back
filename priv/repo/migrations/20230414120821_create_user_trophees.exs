defmodule BougBack.Repo.Migrations.CreateUserTrophies do
  use Ecto.Migration

  def change do
    create table(:user_trophies) do
      add :user_id, references(:users, type: :binary_id)
      add :trophy_id, references(:trophies, type: :binary_id)

      timestamps()
    end
  end
end
