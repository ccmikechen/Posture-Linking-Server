use Mix.Config

config :poselink, Poselink.Repo,
  username: "postgres",
  password: "postgres"

config :pushex,
  gcm: [
    default_app: "poselink_app",
    apps: [
      [name: "poselink_app", auth_key: "AIzaSyDWEKTiYWfwRbT31x46GZOiqyA7oczPLEQ"]
    ]
  ]
