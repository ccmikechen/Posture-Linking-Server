defmodule Poselink.TriggerTest do
  use Poselink.ModelCase

  alias Poselink.Trigger

  @valid_attrs %{config: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Trigger.changeset(%Trigger{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Trigger.changeset(%Trigger{}, @invalid_attrs)
    refute changeset.valid?
  end
end
