defmodule Poselink.Repo.Migrations.CreateClassification do
  use Ecto.Migration

  def change do
    create table(:classifications) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:classifications, [:name])
  end
end
