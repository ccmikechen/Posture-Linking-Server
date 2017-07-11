defmodule Poselink.Repo.Migrations.CreateTrigger do
  use Ecto.Migration

  def change do
    create table(:triggers) do
      add :config, :string, null: false
      add :event_id, references(:events, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:triggers, [:event_id])

  end
end
