defmodule Poselink.TriggerSupervisor do

  @trigger_services %{
    1 => Poselink.TriggerService.ButtonTrigger
  }

  def start_link() do
    import Supervisor.Spec

    children = [
      worker(Poselink.TriggerServer, []),
      worker(Poselink.ClientTriggerHandler, [@trigger_services]),
      supervisor(Poselink.TriggerService, [@trigger_services])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
