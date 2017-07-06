defmodule Poselink.TriggerController do
  use Poselink.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def trigger(conn, %{"service_id" => service_id, "payload" => payload}) do
    current_user = Guardian.Plug.current_resource(conn)

    IO.inspect current_user

    Poselink.ClientTriggerHandler.handle_trigger(
      current_user,
      service_id,
      payload
    )

    conn
    |> send_resp(200, "{}")
  end
end
