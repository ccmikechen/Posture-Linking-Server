defmodule Poselink.UserServiceConfigController do
  use Poselink.Web, :controller

  alias Poselink.UserServiceConfig

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def index(conn, _params) do
    user_service_configs = Repo.all(UserServiceConfig)
    render(conn, "index.json", user_service_configs: user_service_configs)
  end

  def create(conn, %{"service_id" => service_id, "config" => config}) do
    current_user = Guardian.Plug.current_resource(conn)
    IO.puts "Service Id:"
    IO.inspect service_id
    changeset =
      %UserServiceConfig{
        user_id: current_user.id,
        service_id: service_id,
        config: Poison.encode!(config)
      }
      |> UserServiceConfig.changeset

    case Repo.insert(
          changeset,
          on_conflict: :replace_all,
          conflict_target: [:user_id, :service_id]) do
      {:ok, user_service_config} ->
        conn
        |> put_status(:created)
        |> render("show.json", user_service_config: user_service_config)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_service_config = Repo.get!(UserServiceConfig, id)
    render(conn, "show.json", user_service_config: user_service_config)
  end

  def show(conn, %{"service_id" => service_id}) do
    current_user = Guardian.Plug.current_resource(conn)
    user_service_config =
      Repo.get_by!(UserServiceConfig,
        user_id: current_user.id,
        service_id: service_id)

    render(conn, "show.json", user_service_config: user_service_config)
  end

  def update(conn, %{"service_id" => service_id, "config" => config}) do
    current_user = Guardian.Plug.current_resource(conn)
    user_service_config =
      Repo.get_by!(UserServiceConfig,
        user_id: current_user.id,
        service_id: service_id)

    changeset =
      UserServiceConfig.changeset(
        user_service_config, %{"config" => Poison.encode!(config)})

    case Repo.update(changeset) do
      {:ok, user_service_config} ->
        render(conn, "show.json", user_service_config: user_service_config)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_service_config = Repo.get!(UserServiceConfig, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_service_config)

    send_resp(conn, :no_content, "")
  end
end
