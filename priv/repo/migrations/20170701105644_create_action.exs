defmodule Poselink.Repo.Migrations.CreateAction do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :config, :string, null: false
      add :event_id, references(:events, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:actions, [:event_id])

  end
end
