use Mix.Config

config :poselink, Poselink.Repo,
  username: "postgres",
  password: "postgres"

config :poselink, Poselink.ActionService.NotificationAction,
  api_key: "AAAAVYydE-E:APA91bG1zPKY0jtXGE_iptnIbCXCWgOox0rfvUqxcJo_HHHMKXmArUWumSHLCjaGmSdxmhVWMU1dTpVpOwb0piTTKaxiL8gADvFOTlyTdIb-X2X5tw4qeO8Pv_5b5TDoxWRrRXexwMu6"
