defmodule Poselink.LineMessagingController do
  use Poselink.Web, :controller

  def callback(conn, %{"events" => events}) do
    Enum.each(events, fn event ->
      Poselink.TriggerService.LineMessagingTrigger.handle_event(event)
    end)

    send_resp(conn, 200, "")
  end
end
