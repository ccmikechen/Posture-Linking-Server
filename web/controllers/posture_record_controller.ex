defmodule Poselink.PostureRecordController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.PostureRecord
  alias Poselink.PostureRecordDetail

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def show(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    records_query = from r in PostureRecord, where: r.recorder_user_id == ^current_user.id

    records =
      records_query
      |> Repo.all()
      |> Repo.preload(:posture)
      |> Enum.map(fn record ->
        length_query =
          from d in PostureRecordDetail,
          where: d.posture_record_id == ^record.id,
          select: count(d.id)
        [length] = Repo.all(length_query)

        %{record: record, length: length}
      end)
      render(conn, "index.json", records: records)
  end
end
