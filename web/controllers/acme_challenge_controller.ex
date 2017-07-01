defmodule Poselink.AcmeChallengeController do
  use Poselink.Web, :controller

  def show(conn, %{"challenge" => "wDdXe8tgU5Cs-593pnxdsqup8dzfxG1sccR717uFTA8"}) do
    send_resp(conn, 200, "TheHashInTheFile")
  end
  def show(conn, _) do
    send_resp(conn, 200, "Not valid")
  end
end
