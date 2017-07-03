defmodule Poselink.Router do
  use Poselink.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/.well-known", Poselink do
    get "/acme-challenge/:challenge", AcmeChallengeController, :show
  end

  scope "/api", Poselink do
    pipe_through :api

    get "/", PingController, :show

    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    get "/sessions/user", SessionController, :show_user

    resources "/users", UserController, only: [:create]

    post "/trigger/trigger", TriggerController, :trigger
    
  end
end
