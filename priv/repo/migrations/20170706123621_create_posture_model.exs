defmodule Poselink.Repo.Migrations.CreatePostureModel do
  use Ecto.Migration

  def change do
    create table(:posture_models) do
      add :description, :string
      add :status, :string, null: false
      add :path, :string, null: false

      timestamps()
    end

  end
end
