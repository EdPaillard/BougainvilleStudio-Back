defmodule BougBack.Repo.Migrations.CreateFragments do
  use Ecto.Migration

  def change do
    create table(:fragments) do
      # add :types, {:array, :string}
      add :title, :string
      add :description, :string
      add :number, :integer

      timestamps()
    end
  end
end
