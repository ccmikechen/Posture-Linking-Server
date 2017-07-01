defmodule Poselink.Repo.Migrations.CreateNotificationLog do
  use Ecto.Migration

  def change do
    create table(:notification_logs) do
      add :message, :string, null: false
      add :notification_type_id, references(:notification_types, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:notification_logs, [:notification_type_id])

  end
end
