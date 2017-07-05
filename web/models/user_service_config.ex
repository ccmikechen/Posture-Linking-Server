defmodule Poselink.UserServiceConfig do
  use Poselink.Web, :model

  schema "user_service_configs" do
    field :config, :string
    field :status, :string
    belongs_to :user, Poselink.User
    belongs_to :service, Poselink.Service

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:config, :status])
    |> validate_required([:config, :status])
  end
end
