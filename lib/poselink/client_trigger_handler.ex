defmodule Poselink.ClientTriggerHandler do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.TriggerService

  def start_link do
    trigger_services = load_trigger_services()

    GenServer.start_link(__MODULE__, trigger_services, [name: __MODULE__])
  end

  def handle_trigger(user, service_id, payload) do
    GenServer.cast(__MODULE__, {:handle_trigger, user, service_id, payload})
  end

  def handle_cast({:handle_trigger, user, service_id, payload}, trigger_services) do
    service = trigger_services[service_id]
    service.trigger(user, payload)

    {:noreply, trigger_services}
  end

  defp load_trigger_services do
    [services: services] = Application.get_env(:poselink, TriggerService)
    Enum.reduce(services, %{}, fn {name, module}, acc ->
      case Repo.get_by(Service, name: name) do
        nil ->
          IO.puts "Service #{name} not found"
          acc
        trigger_service ->
          Map.put(acc, trigger_service.id, module)
      end
    end)
  end
end
