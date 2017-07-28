defmodule Poselink.PrivacyPolicyController do
  use Poselink.Web, :controller

  def show(conn, _params) do
    render(conn, "index.html")
  end
end
