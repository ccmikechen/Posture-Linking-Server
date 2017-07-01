defmodule Poselink.CombinationControllerTest do
  use Poselink.ConnCase

  alias Poselink.Combination
  @valid_attrs %{description: "some content", status: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, combination_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    combination = Repo.insert! %Combination{}
    conn = get conn, combination_path(conn, :show, combination)
    assert json_response(conn, 200)["data"] == %{"id" => combination.id,
      "user_id" => combination.user_id,
      "trigger_id" => combination.trigger_id,
      "action_id" => combination.action_id,
      "description" => combination.description,
      "status" => combination.status}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, combination_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, combination_path(conn, :create), combination: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Combination, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, combination_path(conn, :create), combination: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    combination = Repo.insert! %Combination{}
    conn = put conn, combination_path(conn, :update, combination), combination: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Combination, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    combination = Repo.insert! %Combination{}
    conn = put conn, combination_path(conn, :update, combination), combination: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    combination = Repo.insert! %Combination{}
    conn = delete conn, combination_path(conn, :delete, combination)
    assert response(conn, 204)
    refute Repo.get(Combination, combination.id)
  end
end
