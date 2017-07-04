defmodule Poselink.UserServiceConfigTest do
  use Poselink.ModelCase

  alias Poselink.UserServiceConfig

  @valid_attrs %{config: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserServiceConfig.changeset(%UserServiceConfig{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserServiceConfig.changeset(%UserServiceConfig{}, @invalid_attrs)
    refute changeset.valid?
  end
end
