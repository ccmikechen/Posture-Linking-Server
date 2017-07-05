use Mix.Config

alias Poselink.TriggerService
alias Poselink.ActionService

config :poselink, TriggerService,
  services: [
    {"button", TriggerService.ButtonTrigger}
  ]

config :poselink, ActionService,
  services: [
    {"notification", ActionService.NotificationAction},
    {"line notify", ActionService.LineNotifyAction}
  ]
