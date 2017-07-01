defmodule Poselink.Repo.Migrations.CreateAction do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :config, :string, null: false
      add :service_id, references(:services, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:actions, [:service_id])

  end
end
