defmodule Poselink.NotificationTypeTest do
  use Poselink.ModelCase

  alias Poselink.NotificationType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = NotificationType.changeset(%NotificationType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = NotificationType.changeset(%NotificationType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
