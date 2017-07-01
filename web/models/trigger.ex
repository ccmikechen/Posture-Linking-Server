defmodule Poselink.Trigger do
  use Poselink.Web, :model

  schema "triggers" do
    field :config, :string
    belongs_to :service, Poselink.Service

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:config])
    |> validate_required([:config])
  end
end
