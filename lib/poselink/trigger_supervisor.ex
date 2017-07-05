defmodule Poselink.TriggerSupervisor do

  alias Poselink.TriggerService

  @trigger_services %{
    1 => TriggerService.ButtonTrigger
  }

  def start_link() do
    import Supervisor.Spec

    children = [
      worker(Poselink.TriggerServer, []),
      worker(Poselink.ClientTriggerHandler, []),
      supervisor(Poselink.TriggerService, [])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
