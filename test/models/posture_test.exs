defmodule Poselink.PostureTest do
  use Poselink.ModelCase

  alias Poselink.Posture

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Posture.changeset(%Posture{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Posture.changeset(%Posture{}, @invalid_attrs)
    refute changeset.valid?
  end
end
