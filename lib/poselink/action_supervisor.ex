defmodule Poselink.ActionSupervisor do

  alias Poselink.ActionService

  @action_services %{
    2 => ActionService.NotificationAction
  }

  def start_link() do
    import Supervisor.Spec

    children = [
      worker(Poselink.ActionServer, [@action_services]),
      supervisor(Poselink.ActionService, [@action_services])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
