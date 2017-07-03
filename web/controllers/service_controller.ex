defmodule Poselink.ServiceController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.Service

  def index(conn, _params) do
    query =
      from s in Service,
      preload: [:classification]

    services = Repo.all(query)

    render(conn, "index.json", services: services)
  end
end
