defmodule Poselink.EventTest do
  use Poselink.ModelCase

  alias Poselink.Event

  @valid_attrs %{description: "some content", name: "some content", options: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
