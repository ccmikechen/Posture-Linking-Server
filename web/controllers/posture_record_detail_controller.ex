defmodule Poselink.PostureRecordDetailController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.PostureRecord
  alias Poselink.PostureRecordDetail

  def show(conn, %{id: id}) do
    current_user = Guardian.Plug.current_resource(conn)
    user_id = current_user.id

    case Repo.get(PostureRecord, id) do
      record = %{recorder_user_id: ^user_id} ->
        details_query =
          from d in PostureRecordDetail,
          where: d.posture_record_id == ^record.id
        details = Repo.all(details_query)

        render(conn, "index.json", posture_record_details: details)
      _ ->
        render(conn, "index.json", posture_record_details: [])
    end
  end
end
