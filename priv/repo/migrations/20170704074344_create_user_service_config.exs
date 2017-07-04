defmodule Poselink.Repo.Migrations.CreateUserServiceConfig do
  use Ecto.Migration

  def change do
    create table(:user_service_configs) do
      add :config, :string, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :service_id, references(:services, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:user_service_configs, [:user_id])
    create index(:user_service_configs, [:service_id])

    create unique_index(:user_service_configs, [:user_id, :service_id])
  end
end
