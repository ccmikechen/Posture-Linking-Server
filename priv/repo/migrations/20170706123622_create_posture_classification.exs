defmodule Poselink.Repo.Migrations.CreatePostureClassification do
  use Ecto.Migration

  def change do
    create table(:posture_classifications) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:posture_classifications, [:name])
  end
end
