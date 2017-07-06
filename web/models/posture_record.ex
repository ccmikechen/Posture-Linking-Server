defmodule Poselink.PostureRecord do
  use Poselink.Web, :model

  schema "posture_records" do
    field :height, :float
    field :weight, :float
    field :insole_size, :string
    field :status, :string
    belongs_to :posture, Poselink.Posture
    belongs_to :recorder_user, Poselink.RecorderUser

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:height, :weight, :insole_size, :status])
    |> validate_required([:height, :weight, :insole_size, :status])
  end
end
