defmodule Poselink.Posture do
  use Poselink.Web, :model

  schema "postures" do
    field :name, :string
    belongs_to :classification, Poselink.Classification

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
