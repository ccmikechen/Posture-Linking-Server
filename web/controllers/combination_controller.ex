defmodule Poselink.CombinationController do
  use Poselink.Web, :controller

  alias Poselink.Combination

  def index(conn, _params) do
    combinations = Repo.all(Combination)
    render(conn, "index.json", combinations: combinations)
  end

  def create(conn, %{"combination" => combination_params}) do
    changeset = Combination.changeset(%Combination{}, combination_params)

    case Repo.insert(changeset) do
      {:ok, combination} ->
        conn
        |> put_status(:created)
   #     |> put_resp_header("location", combination_path(conn, :show, combination))
        |> render("show.json", combination: combination)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    combination = Repo.get!(Combination, id)
    render(conn, "show.json", combination: combination)
  end

  def update(conn, %{"id" => id, "combination" => combination_params}) do
    combination = Repo.get!(Combination, id)
    changeset = Combination.changeset(combination, combination_params)

    case Repo.update(changeset) do
      {:ok, combination} ->
        render(conn, "show.json", combination: combination)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Poselink.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    combination = Repo.get!(Combination, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(combination)

    send_resp(conn, :no_content, "")
  end
end
