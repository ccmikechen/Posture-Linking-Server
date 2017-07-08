defmodule Poselink.PostureController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.Posture
  alias Poselink.PostureRecord
  alias Poselink.PostureRecordDetail
  alias Poselink.PostureModel

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def index(conn, _params) do
    postures = Posture |> Repo.all() |> Repo.preload(:classification)

    render(conn, "index.json", postures: postures)
  end

  def dataset(conn, _params) do
    dataset = load_all_posture_data()

    render(conn, "dataset.json", dataset: dataset)
  end

  def build(conn, %{"description" => description}) do
    dataset = load_all_posture_data()
    graph_path = Poselink.PostureModelBuilder.build(dataset, description)

    new_model = %PostureModel{
      path: graph_path,
      description: description,
      status: "available"
    }
    Repo.insert(new_model)

    render(conn, "build.json", graph_path: graph_path)
  end

  def model(conn, _params) do
    lastest_model =
      from(m in PostureModel,
        where: m.status == "available")
    |> last()
    |> Repo.one()

    send_file(conn, 200, model_path: lastest_model.path)
  end

  defp load_all_posture_data do
    records = Poselink.PostureRecord |> Repo.all() |> Repo.preload(:posture)
    records
    |> Enum.map(fn record ->
      load_record(record)
    end)
    |> Enum.filter(fn records ->
      records != []
    end)
    |> List.flatten()
    |> Enum.reduce({[], []}, fn {data, type}, {acc_data, acc_type} ->
      {[data | acc_data], [type | acc_type]}
    end)
  end

  defp load_record(record, batch \\ 16) do
    type = record.posture.id

    query =
      from d in PostureRecordDetail,
      where: d.posture_record_id == ^record.id,
      order_by: [:sequence_number],
      select: [
        d.left_insole_acc_x,
        d.left_insole_acc_y,
        d.left_insole_acc_z,
        d.left_insole_pressure_a,
        d.left_insole_pressure_b,
        d.left_insole_pressure_c,
        d.left_insole_pressure_d,
        d.right_insole_acc_x,
        d.right_insole_acc_y,
        d.right_insole_acc_z,
        d.right_insole_pressure_a,
        d.right_insole_pressure_b,
        d.right_insole_pressure_c,
        d.right_insole_pressure_d,
        d.band_acc_x,
        d.band_acc_y,
        d.band_acc_z
      ]
    query
    |> Repo.all()
    |> Enum.chunk(batch)
    |> Enum.map(fn data ->
      {data, type}
    end)
  end
end
