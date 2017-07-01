defmodule Poselink.Repo.Migrations.CreateNotificationType do
  use Ecto.Migration

  def change do
    create table(:notification_types) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:notification_types, [:name])
  end
end
