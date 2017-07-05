defmodule Poselink.TriggerService do

  alias Poselink.Repo
  alias Poselink.Service

  def start_link do
    import Supervisor.Spec

    children = Enum.map(load_trigger_services,
      fn {id, service} ->
        worker(service, [id])
      end)

    opts = [strategy: :one_for_one, name: Poselink.TriggerService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp load_trigger_services do
    [services: services] = Application.get_env(:poselink, __MODULE__)
    services
    |> Enum.map(fn {name, module} ->
      trigger_service = Repo.get_by(Service, name: name)
      {trigger_service.id, module}
    end)
  end
end
