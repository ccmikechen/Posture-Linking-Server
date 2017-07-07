defmodule Poselink.Repo.Migrations.CreatePostureRecordDetail do
  use Ecto.Migration

  def change do
    create table(:posture_record_details) do
      add :left_insole_acc_x, :float, null: false
      add :left_insole_acc_y, :float, null: false
      add :left_insole_acc_z, :float, null: false
      add :left_insole_pressure_a, :float, null: false
      add :left_insole_pressure_b, :float, null: false
      add :left_insole_pressure_c, :float, null: false
      add :left_insole_pressure_d, :float, null: false
      add :right_insole_acc_x, :float, null: false
      add :right_insole_acc_y, :float, null: false
      add :right_insole_acc_z, :float, null: false
      add :right_insole_pressure_a, :float, null: false
      add :right_insole_pressure_b, :float, null: false
      add :right_insole_pressure_c, :float, null: false
      add :right_insole_pressure_d, :float, null: false
      add :band_acc_x, :float, null: false
      add :band_acc_y, :float, null: false
      add :band_acc_z, :float, null: false
      add :sequence_number, :integer, null: false
      add :posture_record_id, references(:posture_records, on_delete: :nothing)

      timestamps()
    end
    create index(:posture_record_details, [:posture_record_id])
    
    create unique_index(:posture_record_details, [:posture_record_id, :sequence_number])
  end
end
