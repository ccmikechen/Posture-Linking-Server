defmodule Poselink.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string, null: false
      add :icon, :string
      add :type, :integer, null: false
      add :classification_id, references(:classifications, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:services, [:classification_id])

    create unique_index(:services, [:type, :name])
  end
end
