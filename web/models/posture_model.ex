defmodule Poselink.PostureModel do
  use Poselink.Web, :model

  schema "posture_models" do
    field :description, :string
    field :status, :string
    field :path, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :status, :path])
    |> validate_required([:description, :status, :path])
  end
end
