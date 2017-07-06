defmodule Poselink.Repo.Migrations.CreatePosture do
  use Ecto.Migration

  def change do
    create table(:postures) do
      add :name, :string, null: false
      add :classification_id, references(:posture_classifications, on_delete: :nothing)
      add :type, :integer, null: false

      timestamps()
    end
    create index(:postures, [:classification_id])

    create unique_index(:postures, [:name])
  end
end
