defmodule Poselink.PostureRecordDetail do
  use Poselink.Web, :model

  schema "posture_record_details" do
    field :left_insole_acc_x, :float
    field :left_insole_acc_y, :float
    field :left_insole_acc_z, :float
    field :left_insole_pressure_a, :float
    field :left_insole_pressure_b, :float
    field :left_insole_pressure_c, :float
    field :left_insole_pressure_d, :float
    field :right_insole_acc_x, :float
    field :right_insole_acc_y, :float
    field :right_insole_acc_z, :float
    field :right_insole_pressure_a, :float
    field :right_insole_pressure_b, :float
    field :right_insole_pressure_c, :float
    field :right_insole_pressure_d, :float
    field :band_acc_x, :float
    field :band_acc_y, :float
    field :band_acc_z, :float
    field :band_gyro_x, :float
    field :band_gyro_y, :float
    field :band_gyro_z, :float
    field :belt_acc_x, :float
    field :belt_acc_y, :float
    field :belt_acc_z, :float
    field :sequence_number, :integer
    belongs_to :posture_record, Poselink.PostureRecord

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:left_insole_acc_x, :left_insole_acc_y, :left_insole_acc_z, :left_insole_pressure_a, :left_insole_pressure_b, :left_insole_pressure_c, :left_insole_pressure_d, :right_insole_acc_x, :right_insole_acc_y, :right_insole_acc_z, :right_insole_pressure_a, :right_insole_pressure_b, :right_insole_pressure_c, :right_insole_pressure_d, :band_acc_x, :band_acc_y, :band_acc_z, :sequence_number])
    |> validate_required([:left_insole_acc_x, :left_insole_acc_y, :left_insole_acc_z, :left_insole_pressure_a, :left_insole_pressure_b, :left_insole_pressure_c, :left_insole_pressure_d, :right_insole_acc_x, :right_insole_acc_y, :right_insole_acc_z, :right_insole_pressure_a, :right_insole_pressure_b, :right_insole_pressure_c, :right_insole_pressure_d, :band_acc_x, :band_acc_y, :band_acc_z, :belt_acc_x, :belt_acc_y, :belt_acc_z, :sequence_number])
  end
end
