defmodule Poselink.LineNotifyController do
  use Poselink.Web, :controller

  def callback(conn, params) do
    IO.puts "line notify callback"
    IO.inspect params

    send_resp(conn, 200, "")
  end
end
