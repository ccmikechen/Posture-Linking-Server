defmodule Poselink.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :options, :string, null: false
      add :service_id, references(:services, on_delete: :nothing)

      timestamps()
    end
    create index(:events, [:service_id])

    create unique_index(:events, [:service_id, :name])
  end
end
