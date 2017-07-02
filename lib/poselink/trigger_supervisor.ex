defmodule Poselink.TriggerSupervisor do
  
  def start_link() do
    import Supervisor.Spec

    children = [
      worker(Poselink.TriggerServer, []),
      supervisor(Poselink.TriggerService, [])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
