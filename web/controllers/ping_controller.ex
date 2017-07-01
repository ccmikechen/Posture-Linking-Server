defmodule Poselink.PingController do
  use Poselink.Web, :controller

  def show(conn, _params) do
    render(conn, Poselink.PingView, "show.json")
  end
end
