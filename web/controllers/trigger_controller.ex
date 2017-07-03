defmodule Poselink.TriggerController do
  use Poselink.Web, :controller

  alias Poselink.Repo
  alias Pselink.Trigger
  alias Poselink.User

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def trigger(conn, %{"service_id" => service_id, "payload" => payload}) do
    current_user = Guardian.Plug.current_resource(conn)

    Poselink.TriggerServer.trigger(current_user.id, service_id, payload)

    conn
    |> send_resp(200, "")
  end
end
