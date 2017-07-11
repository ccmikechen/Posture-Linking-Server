defmodule Poselink.Event do
  use Poselink.Web, :model

  schema "events" do
    field :name, :string
    field :description, :string
    field :options, :string
    belongs_to :service, Poselink.Service

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :options])
    |> validate_required([:name, :description, :options])
  end
end
