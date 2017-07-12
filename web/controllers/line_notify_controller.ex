defmodule Poselink.LineNotifyController do
  use Poselink.Web, :controller

  def callback(conn, %{"code" => code}) do
    render(conn, "index.html", code: code)
  end
end
