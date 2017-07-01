defmodule Poselink.NotificationLogTest do
  use Poselink.ModelCase

  alias Poselink.NotificationLog

  @valid_attrs %{message: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = NotificationLog.changeset(%NotificationLog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = NotificationLog.changeset(%NotificationLog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
