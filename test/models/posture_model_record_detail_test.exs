defmodule Poselink.PostureModelRecordDetailTest do
  use Poselink.ModelCase

  alias Poselink.PostureModelRecordDetail

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostureModelRecordDetail.changeset(%PostureModelRecordDetail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostureModelRecordDetail.changeset(%PostureModelRecordDetail{}, @invalid_attrs)
    refute changeset.valid?
  end
end
