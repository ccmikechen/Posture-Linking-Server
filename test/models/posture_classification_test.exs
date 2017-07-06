defmodule Poselink.PostureClassificationTest do
  use Poselink.ModelCase

  alias Poselink.PostureClassification

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostureClassification.changeset(%PostureClassification{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostureClassification.changeset(%PostureClassification{}, @invalid_attrs)
    refute changeset.valid?
  end
end
