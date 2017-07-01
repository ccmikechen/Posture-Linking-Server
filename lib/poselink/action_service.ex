defmodule Poselink.ActionService do

  def start_link() do
    import Supervisor.Spec

    children = [

    ]

    opts = [strategy: :one_for_one, name: Poselink.ActionService.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
