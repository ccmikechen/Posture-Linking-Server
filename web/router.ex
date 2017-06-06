defmodule Poselink.Router do
  use Poselink.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Poselink do
    pipe_through :api
  end
end
