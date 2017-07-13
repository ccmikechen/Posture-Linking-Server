defmodule Poselink.Router do
  use Poselink.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Poselink do
    pipe_through :api

    get "/ping", PingController, :show
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    get "/sessions/user", SessionController, :show_user
    resources "/users", UserController, only: [:create]
    resources "/services", ServiceController, only: [:index]
    resources "/combinations", CombinationController, except: [:show]
    patch "/combination/status", CombinationController, :update_status
    resources "/user_service_configs",
      UserServiceConfigController, only: [:index, :create]
    get "/user_service_configs", UserServiceConfigController, :show
    patch "/user_service_configs", UserServiceConfigController, :update
    post "/trigger/trigger", TriggerController, :trigger
    get "/posture/postures", PostureController, :index
    get "/posture/dataset", PostureController, :dataset
    get "/posture/model", PostureController, :model
    post "/posture/model/build", PostureController, :build
  end

  scope "/webhook", Poselink do
    pipe_through :api

    get "/line/callback", LineMessagingController, :callback
    post "/line/callback", LineMessagingController, :callback
  end

  scope "/oauth", Poselink do
    get "/authorize", AuthController, :authorize
  end

  scope "/redirect", Poselink do
    pipe_through :browser

    get "/line_notify/callback", LineNotifyController, :callback
    get "/line_notify/token", LineNotifyController, :token
  end
end
