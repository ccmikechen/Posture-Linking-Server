defmodule Poselink.ActionService do

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.ActionService

  def start_link do
    import Supervisor.Spec

    children = Enum.map(load_action_services,
      fn {id, service} ->
        worker(service, [id])
      end)

    opts = [strategy: :one_for_one, name: Poselink.ActionService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp load_action_services do
    [services: services] = Application.get_env(:poselink, __MODULE__)
    services
    |> Enum.map(fn {name, module} ->
      action_service = Repo.get_by(Service, name: name)
      {action_service.id, module}
    end)
  end
end
