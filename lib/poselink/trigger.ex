defmodule Poselink.Trigger do
  
  def start_link() do
    import Supervisor.Spec

    children = [
      worker(Poselink.TriggerServer, []),
      supervisor(Poselink.TriggerService, [])
    ]

    opts = [strategy: :one_for_one, name: Poselink.Trigger.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
