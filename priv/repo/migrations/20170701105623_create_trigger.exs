defmodule Poselink.Repo.Migrations.CreateTrigger do
  use Ecto.Migration

  def change do
    create table(:triggers) do
      add :config, :string, null: false
      add :service_id, references(:services, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:triggers, [:service_id])

  end
end
