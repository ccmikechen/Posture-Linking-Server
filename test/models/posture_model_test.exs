defmodule Poselink.PostureModelTest do
  use Poselink.ModelCase

  alias Poselink.PostureModel

  @valid_attrs %{description: "some content", path: "some content", status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostureModel.changeset(%PostureModel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostureModel.changeset(%PostureModel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
