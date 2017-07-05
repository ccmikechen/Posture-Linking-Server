use Mix.Config

alias Poselink.TriggerService
alias Poselink.ActionService

config :poselink, TriggerService,
  services: [
    {"button", TriggerService.ButtonTrigger},
    {"timer", TriggerService.TimerTrigger},
    {"line messaging", TriggerService.LineMessagingTrigger}
  ]

config :poselink, ActionService,
  services: [
    {"notification", ActionService.NotificationAction},
    {"line notify", ActionService.LineNotifyAction}
  ]
