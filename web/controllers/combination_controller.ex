defmodule Poselink.CombinationController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.Combination
  alias Poselink.Trigger
  alias Poselink.Action

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    query =
      from c in Combination,
      where: c.user_id == ^current_user.id and c.status != 2,
      preload: [:trigger,:action],
      order_by: [:id]

    combinations = Repo.all(query)

    render(conn, "index.json", combinations: combinations)
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    {:ok, trigger} = create_trigger(params["trigger"])
    {:ok, action} = create_action(params["action"])

    changeset = Combination.changeset(
      %Combination{
        user_id: current_user.id,
        trigger_id: trigger.id,
        action_id: action.id,
        description: params["description"],
        status: 1
      }
    )

    case Repo.insert(changeset) do
      {:ok, combination} ->
        conn
        |> put_status(:created)
        |> render("show.json", combination: Repo.preload(combination, [:trigger, :action]))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, params) do
    combination = Repo.get(Combination, params["id"]) |> Repo.preload([:trigger, :action])

    trigger_changeset = Trigger.changeset(combination.trigger,
      %{
        "config" => Poison.encode!(params["trigger"]["config"])
      })
    Repo.update(trigger_changeset)

    action_changeset = Action.changeset(combination.action,
      %{
        "config" => Poison.encode!(params["action"]["config"])
      })
    Repo.update(action_changeset)

    combination_changeset = Combination.changeset(combination,
      %{
        "description" => params["description"],
        "status" => params["status"]
      })

    case Repo.update(combination_changeset) do
      {:ok, new_combination} ->
        conn
        |> render("show.json", combination: Repo.preload(new_combination, [:trigger, :action]))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => combination_id}) do
    combination = Repo.get(Combination, combination_id)
    changeset = Combination.changeset(combination, %{"status" => 2})

    case Repo.update(changeset) do
      {:ok, new_combination} ->
        conn
        |> render("show.json", combination: Repo.preload(new_combination, [:trigger, :action]))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update_status(conn, %{"id" => combination_id, "status" => status}) do
    combination = Repo.get(Combination, combination_id)
    changeset = Combination.changeset(combination, %{"status" => status})

    case Repo.update(changeset) do
      {:ok, new_combination} ->
        conn
        |> render("show.json", combination: Repo.preload(new_combination, [:trigger, :action]))
      {:error, changeset} ->
        conn
        |> put_status(:unproccessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changest: changeset)
    end
  end

  defp create_trigger(params) do
    changeset = Trigger.changeset(
      %Trigger{
        service_id: params["service_id"],
        config: Poison.encode!(params["config"])
      }
    )
    Repo.insert(changeset)
  end

  defp create_action(params) do
    changeset = Action.changeset(
      %Action{
        service_id: params["service_id"],
        config: Poison.encode!(params["config"])
      }
    )
    Repo.insert(changeset)
  end
end
