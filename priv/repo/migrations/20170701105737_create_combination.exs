defmodule Poselink.Repo.Migrations.CreateCombination do
  use Ecto.Migration

  def change do
    create table(:combinations) do
      add :description, :string
      add :status, :integer, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :trigger_id, references(:triggers, on_delete: :nothing), null: false
      add :action_id, references(:actions, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:combinations, [:user_id])
    create index(:combinations, [:trigger_id])
    create index(:combinations, [:action_id])

  end
end
