defmodule Poselink.PostureRecordTest do
  use Poselink.ModelCase

  alias Poselink.PostureRecord

  @valid_attrs %{height: "120.5", insole_size: "some content", status: "some content", weight: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostureRecord.changeset(%PostureRecord{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostureRecord.changeset(%PostureRecord{}, @invalid_attrs)
    refute changeset.valid?
  end
end
