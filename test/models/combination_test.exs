defmodule Poselink.CombinationTest do
  use Poselink.ModelCase

  alias Poselink.Combination

  @valid_attrs %{description: "some content", status: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Combination.changeset(%Combination{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Combination.changeset(%Combination{}, @invalid_attrs)
    refute changeset.valid?
  end
end
