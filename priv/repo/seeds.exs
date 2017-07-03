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

# Initial constants

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
  "developer"
]

trigger_services = [
  %{
    name: "button",
    icon: "",
    classification: "smart phone"
  }
]
action_services = [
  %{
    name: "notification",
    icon: "",
    classification: "smart phone"
  }
]

combinations = [
  %{
    trigger: %{
      service: "button",
      config: ""
    },
    action: %{
      service: "notification",
      config: ""
    },
    user: "testuser",
    description: "",
    status: 1
  },
  %{
    trigger: %{
      service: "button",
      config: ""
    },
    action: %{
      service: "notification",
      config: ""
    },
    user: "testuser",
    description: "",
    status: 1
  },
  %{
    trigger: %{
      service: "button",
      config: ""
    },
    action: %{
      service: "notification",
      config: ""
    },
    user: "testuser",
    description: "",
    status: 1
  }
]

# Ecto functions

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
