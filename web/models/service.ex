defmodule Poselink.Service do
  use Poselink.Web, :model

  schema "services" do
    field :name, :string
    field :icon, :string
    field :type, :integer
    belongs_to :classification, Poselink.Classification

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :icon, :type])
    |> validate_required([:name, :icon, :type])
  end
end
