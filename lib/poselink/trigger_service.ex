defmodule Poselink.TriggerService do

  def start_link(trigger_services) do
    import Supervisor.Spec

    children =
      trigger_services
      |> Enum.to_list
      |> Enum.map(fn {id, service} -> worker(service, [id]) end)

    opts = [strategy: :one_for_one, name: Poselink.TriggerService.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
