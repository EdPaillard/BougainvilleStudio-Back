defmodule BougBack.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :pseudo, :string
      add :about, :string
      add :profil_img, :string
      add :password, :string
      add :age, :integer
      add :email, :string
      add :ville, :string

      timestamps()
    end

    create unique_index(:users, [:email, :pseudo])

  end
end
