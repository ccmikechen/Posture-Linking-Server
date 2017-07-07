defmodule Poselink.Repo.Migrations.CreatePostureRecord do
  use Ecto.Migration

  def change do
    create table(:posture_records) do
      add :height, :float, null: false
      add :weight, :float, null: false
      add :insole_size, :string, null: false
      add :status, :string, null: false
      add :posture_id, references(:postures, on_delete: :nothing)
      add :recorder_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:posture_records, [:posture_id])
    create index(:posture_records, [:recorder_user_id])
  end
end
