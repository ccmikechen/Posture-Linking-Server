defmodule Poselink.ActionTest do
  use Poselink.ModelCase

  alias Poselink.Action

  @valid_attrs %{config: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Action.changeset(%Action{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Action.changeset(%Action{}, @invalid_attrs)
    refute changeset.valid?
  end
end
