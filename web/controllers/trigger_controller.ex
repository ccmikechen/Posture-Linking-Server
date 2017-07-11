defmodule Poselink.TriggerController do
  use Poselink.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  alias Poselink.Trigger

  def trigger(conn, %{"event_id" => event_id, "payload" => payload}) do
    current_user = Guardian.Plug.current_resource(conn)

    Poselink.ClientTriggerHandler.handle_trigger(
      current_user,
      String.to_integer(event_id),
      Poison.decode!(payload)
    )

    send_resp(conn, 200, "{}")
  end
end
