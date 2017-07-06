defmodule Poselink.PostureModelRecordDetail do
  use Poselink.Web, :model

  schema "posture_model_record_details" do
    belongs_to :posture_model, Poselink.PostureModel
    belongs_to :posture_record, Poselink.PostureRecord

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
