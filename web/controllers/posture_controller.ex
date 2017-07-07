defmodule Poselink.PostureController do
  use Poselink.Web, :controller

  alias Poselink.Posture

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def index(conn, _params) do
    postures = Posture |> Repo.all() |> Repo.preload(:classification)

    render(conn, "index.json", postures: postures)
  end
end
