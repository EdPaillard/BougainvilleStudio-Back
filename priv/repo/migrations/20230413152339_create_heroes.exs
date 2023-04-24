defmodule BougBack.Repo.Migrations.CreateHeroes do
  use Ecto.Migration

  def change do
    create table(:heroes) do
      add :background, :string
      add :pnj_picture, :string
      add :pnj_sentence, :string
      add :options, {:map, :string}
      add :save_scene, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
