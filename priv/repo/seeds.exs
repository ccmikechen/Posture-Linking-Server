# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Poselink.Repo.insert!(%Poselink.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query

alias Poselink.Repo
alias Poselink.NotificationType
alias Poselink.Classification
alias Poselink.Service
alias Poselink.Trigger
alias Poselink.Action
alias Poselink.Event
alias Poselink.Combination
alias Poselink.User
alias Poselink.UserServiceConfig

# Initial constants

default_user = %{
  username: "testuser",
  password: "aaaaaaaa",
  email: "test@aaa.com",
  nickname: "test"
}

notification_types = [
  "system",
  "activity",
  "trigger"
]

classifications = [
  "smart phone",
  "posture",
  "device",
  "web service",
  "open data",
  "developer",
  "poselink"
]

trigger_services = [
  %{
    name: "button",
    icon: "",
    classification: "smart phone"
  },
  %{
    name: "timer",
    icon: "",
    classification: "poselink"
  },
  %{
    name: "line messaging",
    icon: "",
    classification: "web service"
  },
  %{
    name: "posture",
    icon: "",
    classification: "posture"
  }
]

action_services = [
  %{
    name: "notification",
    icon: "",
    classification: "smart phone"
  },
  %{
    name: "line notify",
    icon: "",
    classification: "web service"
  },
  %{
    name: "sheet music turner",
    icon: "",
    classification: "web service"
  },
  %{
    name: "smart bulb",
    icon: "",
    classification: "device"
  },
  %{
    name: "slide show",
    icon: "",
    classification: "web service"
  },
  %{
    name: "camera",
    icon: "",
    classification: "smart phone"
  }
]

events = [
  %{
    service: "button",
    name: "on click",
    description: "When button has been clicked",
    options: []
  },
  %{
    service: "timer",
    name: "on time",
    description: "At every specific time",
    options: [
      %{
        "type" => "option",
        "name" => "time",
        "options" => [
          %{name: "10", value: 10},
          %{name: "20", value: 20},
          %{name: "30", value: 30},
          %{name: "60", value: 60},
        ]
      }
    ]
  },
  %{
    service: "line messaging",
    name: "on message",
    description: "When a message has been received",
    options: [
      %{
        "type" => "text",
        "name" => "message"
      }
    ]
  },
  %{
    service: "notification",
    name: "do notification",
    description: "Notify to smart phone",
    options: [
      %{
        "type" => "textarea",
        "name" => "message"
      }
    ]
  },
  %{
    service: "line notify",
    name: "do notification",
    description: "Notify to LINE",
    options: [
      %{
        "type" => "textarea",
        "name" => "message"
      }
    ]
  },
  %{
    service: "sheet music turner",
    name: "turn next",
    description: "Turn to next page of sheet music",
    options: [
    ]
  },
  %{
    service: "sheet music turner",
    name: "turn back",
    description: "Turn to previous page of sheet music",
    options: [
    ]
  },
  %{
    service: "sheet music turner",
    name: "go first",
    description: "Start from first page of sheet music",
    options: [
    ]
  },
  %{
    service: "smart bulb",
    name: "turn on",
    description: "Turn the smart bulb on",
    options: [
    ]
  },
  %{
    service: "smart bulb",
    name: "turn off",
    description: "Turn the smart bulb off",
    options: [
    ]
  },
  %{
    service: "slide show",
    name: "turn next",
    description: "Turn to next page of slide show",
    options: [
    ]
  },
  %{
    service: "slide show",
    name: "turn back",
    description: "Turn to previous page of slide show",
    options: [
    ]
  },
  %{
    service: "slide show",
    name: "go first",
    description: "Start from first page of slide show",
    options: [
    ]
  },
  %{
    service: "camera",
    name: "do capturing",
    description: "Capture the photo",
    options: [
    ]
  },
  %{
    service: "posture",
    name: "on action",
    description: "When did an action",
    options: [
      %{
        "type" => "option",
        "name" => "posture_id",
        "options" => [
          %{name: "Lying down", value: 1},
          %{name: "Lying on front", value: 2},
          %{name: "Sitting", value: 3},
          %{name: "Shaking hand when sitting", value: 4},
          %{name: "Claping hands when sitting", value: 5},
          %{name: "Right step when sitting", value: 6},
          %{name: "Left step when sitting", value: 7},
          %{name: "Cross right leg", value: 8},
          %{name: "Cross left leg", value: 9},
          %{name: "Play computer", value: 10},
          %{name: "Standing", value: 11},
          %{name: "Shaking hand when standing", value: 12},
          %{name: "Jumping", value: 13},
          %{name: "Claping hands when standing", value: 14},
          %{name: "Right step when standing", value: 15},
          %{name: "Left step when standing", value: 16},
          %{name: "Walking", value: 17},
          %{name: "Running", value: 18}
        ]
      }
    ]
  }
]

combinations = [
  %{
    trigger: %{
      service: "button",
      event: "on click",
      config: %{}
    },
    action: %{
      service: "line notify",
      event: "do notification",
      config: %{
        message: "hello"
      }
    },
    user: "testuser",
    description: "當按下按鈕，則發送LINE Notify通知我",
    status: 1
  },
  %{
    trigger: %{
      service: "button",
      event: "on click",
      config: %{},
    },
    action: %{
      service: "notification",
      event: "do notification",
      config: %{
        message: "man"
      }
    },
    user: "testuser",
    description: "當按下按鈕，則透過手機通知我",
    status: 1
  },
  %{
    trigger: %{
      service: "timer",
      event: "on time",
      config: %{
        "time" => "60"
      }
    },
    action: %{
      service: "line notify",
      event: "do notification",
      config: %{
        message: "yo guys!"
      }
    },
    user: "testuser",
    description: "每隔一分鐘就發送LINE Notify通知我",
    status: 1
  }
]

user_service_configs = [
  %{
    user: "testuser",
    service: %{
      type: 2,
      name: "notification"
    },
    config: %{
      gcm: %{
        token: "d6CeRvb70qA:APA91bFTXsXSFrTkCrtbsJ2uwNmFHroHvQo3BBDvq60a133QrLmcVOmwpLS-5fqfN7kZaq3vkmWfBaaI-HBnIxCAV8yMTt6O93wB4nQOBWoz_f7jyK5IPkqN4uc-ChQPGXek4GkLj9bz"
      }
    }
  }, %{
    user: "testuser",
    service: %{
      type: 2,
      name: "line notify"
    },
    config: %{
      line_notify: %{
        token: "kemONXdmtfwbwlZgv6CwFB2799DOzwyvmI8iFh53AEi"
      }
    }
  }, %{
    user: "testuser",
    service: %{
      type: 1,
      name: "line messaging"
    },
    config: %{
      line_messaging: %{
        user_id: "U85020f513ece9f40e777c37b2c4d4b3c"
      }
    }
  }, %{
    user: "testuser",
    service: %{
      type: 1,
      name: "button"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 1,
      name: "timer"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 1,
      name: "posture"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 2,
      name: "sheet music turner"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 2,
      name: "slide show"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 2,
      name: "smart bulb"
    },
    config: %{
    }
  }, %{
    user: "testuser",
    service: %{
      type: 2,
      name: "camera"
    },
    config: %{
    }
  }
]

### Ecto functions

# users
User.registration_changeset(%User{}, %{
      "username" => default_user.username,
      "password" => default_user.password,
      "email" => default_user.email,
      "nickname" => default_user.nickname}
)
|> Repo.insert(on_conflict: :nothing, conflict_target: [:username])

# notification_types
notification_types
|> Enum.map(fn name -> %NotificationType{name: name} end)
|> Enum.each(fn type ->
  Repo.insert(type,
    on_conflict: :replace_all,
    conflict_target: [:name],
    columns: [:name]
  )
end)

# classfications
classifications
|> Enum.map(fn name -> %Classification{name: name} end)
|> Enum.each(fn type ->
  Repo.insert(type,
    on_conflict: :replace_all,
    conflict_target: [:name]
  )
end)

# service type constants
trigger_type = 1
action_type = 2

# trigger_services
trigger_services
|> Enum.map(fn service ->
  %Service{
    name: service.name,
    icon: service.icon,
    type: trigger_type,
    classification_id: Repo.get_by(Classification,
      name: service.classification).id
}
end)
|> Enum.each(fn service ->
  Repo.insert(service,
    on_conflict: :replace_all,
    conflict_target: [:type, :name]
  )
end)

# action_services
action_services
|> Enum.map(fn service ->
  %Service{
    name: service.name,
    icon: service.icon,
    type: action_type,
    classification_id: Repo.get_by(Classification,
      name: service.classification).id
}
end)
|> Enum.each(fn service ->
  Repo.insert(service,
    on_conflict: :replace_all,
    conflict_target: [:type, :name]
  )
end)

# events
events
|> Enum.map(fn event ->
  %Event{
    service_id: Repo.get_by(Service, name: event.service).id,
    name: event.name,
    description: event.description,
    options: Poison.encode!(event.options)
}
end)
|> Enum.each(fn event ->
  Repo.insert(event,
    on_conflict: :replace_all,
    conflict_target: [:service_id, :name])
end)

# combinations
from(c in Combination, where: c.user_id)
combinations
|> Enum.map(fn combination ->
  user_id = Repo.get_by(User, username: combination.user).id

  from(c in Combination, where: c.user_id == ^user_id)
  |> Repo.delete_all

  trigger_service =
    Repo.get_by(Service, name: combination.trigger.service)
  trigger_event =
    Repo.get_by(Event,
      name: combination.trigger.event,
      service_id: trigger_service.id)
  trigger =
    %Trigger{
      event_id: trigger_event.id,
      config: Poison.encode!(combination.trigger.config)
    }

  {:ok, %{id: trigger_id}} = Repo.insert(trigger)


  action_service =
    Repo.get_by(Service, name: combination.action.service)
  action_event =
    Repo.get_by(Event,
      name: combination.action.event,
      service_id: action_service.id)
  action =
    %Action{
      event_id: action_event.id,
      config: Poison.encode!(combination.action.config)
    }
  {:ok, %{id: action_id}} = Repo.insert(action)

  %Combination{
    user_id: user_id,
    trigger_id: trigger_id,
    action_id: action_id,
    description: combination.description,
    status: combination.status
  }
end)
|> Enum.each(fn combination ->
  Repo.insert(combination,
    on_conflict: :replace_all,
    conflict_target: [:user_id, :trigger_id, :action_id]
  )
end)

# user_service_configs
user_service_configs
|> Enum.each(fn config ->
  service =
    Repo.get_by(Service,
      type: config.service.type,
      name: config.service.name
    )
  user = Repo.get_by(User, username: config.user)

  user_service_config =
    %UserServiceConfig{
      user_id: user.id,
      status: "connected",
      service_id: service.id,
      config: Poison.encode!(config.config)
    }
  Repo.insert(user_service_config,
    on_conflict: :replace_all,
    conflict_target: [:user_id, :service_id]
  )
end)

# load postures
Code.load_file("priv/repo/posture_seeds.exs")
