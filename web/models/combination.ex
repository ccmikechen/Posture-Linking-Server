defmodule Poselink.Combination do
  use Poselink.Web, :model

  schema "combinations" do
    field :description, :string
    field :status, :integer
    belongs_to :user, Poselink.User
    belongs_to :trigger, Poselink.Trigger
    belongs_to :action, Poselink.Action

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :status])
    |> validate_required([:description, :status])
  end
end
