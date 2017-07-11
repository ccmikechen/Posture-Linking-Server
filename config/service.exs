use Mix.Config

alias Poselink.TriggerService
alias Poselink.ActionService

config :poselink, TriggerService,
  services: [
    {"button", TriggerService.ButtonTrigger, [
        {"on click", :on_click}
      ]
    },
    {"timer", TriggerService.TimerTrigger, [
        {"on time", :on_time}
      ]
    },
    {"line messaging", TriggerService.LineMessagingTrigger, [
        {"on message", :on_message}
      ]
    }
  ]

config :poselink, ActionService,
  services: [
    {"notification", ActionService.NotificationAction, [
        {"do notification", :do_notification}
      ]
    },
    {"line notify", ActionService.LineNotifyAction, [
        {"do notification", :do_notification}
      ]
    }
  ]
