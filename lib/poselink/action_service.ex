defmodule Poselink.ActionService do

  def start_link(action_services) do
    import Supervisor.Spec
    alias Poselink.ActionService

    children =
      action_services
      |> Enum.to_list
      |> Enum.map(fn {id, service} -> worker(service, [id]) end)

    opts = [strategy: :one_for_one, name: Poselink.ActionService.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
