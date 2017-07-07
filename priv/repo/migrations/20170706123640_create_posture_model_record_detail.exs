defmodule Poselink.Repo.Migrations.CreatePostureModelRecordDetail do
  use Ecto.Migration

  def change do
    create table(:posture_model_record_details) do
      add :posture_model_id, references(:posture_models, on_delete: :nothing)
      add :posture_record_id, references(:posture_records, on_delete: :nothing)

      timestamps()
    end
    create index(:posture_model_record_details, [:posture_model_id])
    create index(:posture_model_record_details, [:posture_record_id])

    create unique_index(:posture_model_record_details, [:posture_model_id, :posture_record_id])
  end
end
