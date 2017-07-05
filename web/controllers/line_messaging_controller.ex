defmodule Poselink.LineMessagingController do
  use Poselink.Web, :controller

  def callback(conn, params) do
    IO.puts "Line Callback"
    IO.inspect params
    send_resp(conn, 200, "")
  end
end
