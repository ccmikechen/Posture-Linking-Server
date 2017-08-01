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

      render(conn, "index.json", records: records)
  end
end
