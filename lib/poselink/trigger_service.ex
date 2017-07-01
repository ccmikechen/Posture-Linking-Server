defmodule Poselink.TriggerService do

  def start_link() do
    import Supervisor.Spec

    children = [

    ]

    opts = [strategy: :one_for_one, name: Poselink.TriggerService.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
