defmodule Poselink.CombinationController do
  use Poselink.Web, :controller

  import Ecto.Query

  alias Poselink.Combination
  alias Poselink.Trigger
  alias Poselink.Action

  plug Guardian.Plug.EnsureAuthenticated,
    handler: Poselink.SessionController

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    query =
      from c in Combination,
      where: c.user_id == ^current_user.id,
      preload: [:trigger,:action]

    combinations = Repo.all(query)

    render(conn, "index.json", combinations: combinations)
  end
end
