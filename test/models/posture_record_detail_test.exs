defmodule Poselink.PostureRecordDetailTest do
  use Poselink.ModelCase

  alias Poselink.PostureRecordDetail

  @valid_attrs %{band_acc_x: "120.5", band_acc_y: "120.5", band_acc_z: "120.5", left_insole_acc_x: "120.5", left_insole_acc_y: "120.5", left_insole_acc_z: "120.5", left_insole_pressure_a: "120.5", left_insole_pressure_b: "120.5", left_insole_pressure_c: "120.5", left_insole_pressure_d: "120.5", right_insole_acc_x: "120.5", right_insole_acc_y: "120.5", right_insole_acc_z: "120.5", right_insole_pressure_a: "120.5", right_insole_pressure_b: "120.5", right_insole_pressure_c: "120.5", right_insole_pressure_d: "120.5", sequence_number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostureRecordDetail.changeset(%PostureRecordDetail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostureRecordDetail.changeset(%PostureRecordDetail{}, @invalid_attrs)
    refute changeset.valid?
  end
end
