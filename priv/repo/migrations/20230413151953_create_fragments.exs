defmodule BougBack.Repo.Migrations.CreateFragments do
  use Ecto.Migration

  def change do
    create table(:fragments) do
      add :title, :string
      add :description, :string
      add :miniature, :string
      add :content, {:array, :map}

      timestamps()
    end
  end
end
