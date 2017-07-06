defmodule Poselink.Posture do
  use Poselink.Web, :model

  schema "postures" do
    field :name, :string
    belongs_to :classification, Poselink.PostureClassification
    field :type, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type])
    |> validate_required([:name, :type])
  end
end
