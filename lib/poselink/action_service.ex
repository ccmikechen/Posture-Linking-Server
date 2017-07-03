defmodule Poselink.ActionService do

  def start_link() do
    import Supervisor.Spec
    alias Poselink.ActionService

    children = [
      worker(ActionService.NotificationAction, [])
    ]

    opts = [strategy: :one_for_one, name: Poselink.ActionService.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
