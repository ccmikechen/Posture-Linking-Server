defmodule Poselink.LineMessagingController do
  use Poselink.Web, :controller

  def callback(conn, params) do
    send_resp(conn, 200, "")
  end
end
