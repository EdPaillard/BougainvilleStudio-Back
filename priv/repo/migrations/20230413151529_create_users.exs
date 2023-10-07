defmodule BougBack.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :pseudo, :string
      add :about, :string
      add :profil_img, :binary
      add :password, :string
      add :email, :string
      add :ville, :string
      add :level, :integer
      add :exp, :integer

      timestamps()
    end

    create unique_index(:users, [:email, :pseudo])

  end
end
