defmodule Poselink.Repo.Migrations.CreatePosture do
  use Ecto.Migration

  def change do
    create table(:postures) do
      add :name, :string, null: false
      add :classification, references(:posture_classifications, on_delete: :nothing)

      timestamps()
    end
    create index(:postures, [:classification])

    create unique_index(:postures, [:name])
  end
end
