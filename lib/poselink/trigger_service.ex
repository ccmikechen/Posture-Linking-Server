defmodule Poselink.TriggerService do

  alias Poselink.Repo
  alias Poselink.Service

  def start_link do
    import Supervisor.Spec

    children =
      load_trigger_services
      |> Enum.filter(fn item -> not(is_nil(item)) end)
      |> Enum.map(fn {id, service} -> worker(service, [id]) end)

    opts = [strategy: :one_for_one, name: Poselink.TriggerService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp load_trigger_services do
    [services: services] = Application.get_env(:poselink, __MODULE__)
    services
    |> Enum.map(fn {name, module} ->
      trigger_service = Repo.get_by(Service, name: name)

      case Repo.get_by(Service, name: name) do
        nil ->
          IO.puts "Service #{name} not found"
          nil
        trigger_service ->
          {trigger_service.id, module}
      end

    end)
  end
end
