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
  }
]

combinations = [
  %{
    trigger: %{
      service: "button",
      config: "{}"
    },
    action: %{
      service: "line notify",
      config: Poison.encode! %{
        content: "hello"
      }
    },
    user: "testuser",
    description: "push hello",
    status: 1
  },
  %{
    trigger: %{
      service: "button",
      config: "{}"
    },
    action: %{
      service: "notification",
      config: Poison.encode! %{
        content: "man"
      }
    },
    user: "testuser",
    description: "push man",
    status: 1
  },
  %{
    trigger: %{
      service: "timer",
      config: "{}"
    },
    action: %{
      service: "line notify",
      config: Poison.encode! %{
        content: "yo guys!"
      }
    },
    user: "testuser",
    description: "yo guys!",
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
  },
  %{
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
  },
  %{
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
  }
]

# Ecto functions

User.registration_changeset(%User{},
  %{
    "username" => default_user.username,
    "password" => default_user.password,
    "email" => default_user.email,
    "nickname" => default_user.nickname
  })
  |> Repo.insert(on_conflict: :nothing, conflict_target: [:username])

notification_types
|> Enum.map(fn name -> %NotificationType{name: name} end)
|> Enum.each(fn type ->
  Repo.insert(type,
    on_conflict: :replace_all,
    conflict_target: [:name],
    columns: [:name]
  )
end)

classifications
|> Enum.map(fn name -> %Classification{name: name} end)
|> Enum.each(fn type ->
  Repo.insert(type,
    on_conflict: :replace_all,
    conflict_target: [:name]
  )
end)

trigger_type = 1
action_type = 2

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
  action = Repo.insert(service,
    on_conflict: :replace_all,
    conflict_target: [:type, :name]
)
  IO.inspect(action)
end)

from(c in Combination, where: c.user_id)
combinations
|> Enum.map(fn combination ->
  user_id = Repo.get_by(User, username: combination.user).id

  from(c in Combination, where: c.user_id == ^user_id)
  |> Repo.delete_all

  trigger =
    %Trigger{
      service_id: Repo.get_by(Service,
        name: combination.trigger.service).id,
      config: combination.trigger.config
    }

  {:ok, %{id: trigger_id}} = Repo.insert(trigger)

  action =
    %Action{
      service_id: Repo.get_by(Service,
        name: combination.action.service).id,
      config: combination.action.config
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

Code.load_file("priv/repo/posture_seeds.exs")
