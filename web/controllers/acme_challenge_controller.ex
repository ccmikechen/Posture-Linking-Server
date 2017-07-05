defmodule Poselink.AcmeChallengeController do
  use Poselink.Web, :controller

  def show(conn, %{"challenge" => challenge}) do
    send_resp(conn, 200, challenge)
  end
end
