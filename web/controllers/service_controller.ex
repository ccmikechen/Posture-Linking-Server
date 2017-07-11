defmodule Poselink.ServiceController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.Service

  def index(conn, _params) do
    services = Service |> Repo.all() |> Repo.preload(:classification)

    render(conn, "index.json", services: services)
  end
end
