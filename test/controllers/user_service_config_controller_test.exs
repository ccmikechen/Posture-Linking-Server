defmodule Poselink.UserServiceConfigControllerTest do
  use Poselink.ConnCase

  alias Poselink.UserServiceConfig
  @valid_attrs %{config: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_service_config_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_service_config = Repo.insert! %UserServiceConfig{}
    conn = get conn, user_service_config_path(conn, :show, user_service_config)
    assert json_response(conn, 200)["data"] == %{"id" => user_service_config.id,
      "user" => user_service_config.user,
      "service" => user_service_config.service,
      "config" => user_service_config.config}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_service_config_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_service_config_path(conn, :create), user_service_config: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserServiceConfig, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_service_config_path(conn, :create), user_service_config: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_service_config = Repo.insert! %UserServiceConfig{}
    conn = put conn, user_service_config_path(conn, :update, user_service_config), user_service_config: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserServiceConfig, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_service_config = Repo.insert! %UserServiceConfig{}
    conn = put conn, user_service_config_path(conn, :update, user_service_config), user_service_config: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_service_config = Repo.insert! %UserServiceConfig{}
    conn = delete conn, user_service_config_path(conn, :delete, user_service_config)
    assert response(conn, 204)
    refute Repo.get(UserServiceConfig, user_service_config.id)
  end
end
