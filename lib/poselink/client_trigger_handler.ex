defmodule Poselink.ClientTriggerHandler do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.Event
  alias Poselink.TriggerService

  def start_link do
    trigger_events = load_trigger_events()

    GenServer.start_link(__MODULE__, trigger_events, [name: __MODULE__])
  end

  def handle_trigger(user, event_id, payload) do
    GenServer.cast(__MODULE__, {:handle_trigger, user, event_id, payload})
  end

  def handle_cast({:handle_trigger, user, event_id, payload}, trigger_events) do
    {trigger, func} = trigger_events[event_id]
    apply(trigger, func, [user, payload])

    {:noreply, trigger_events}
  end

  defp load_trigger_events do
    [services: services] = Application.get_env(:poselink, TriggerService)
    Enum.reduce(services, %{}, fn {service_name, module, events}, acc ->
      case Repo.get_by(Service, name: service_name) do
        nil ->
          IO.puts "Service #{service_name} not found"
          acc
        trigger_service ->
          Enum.reduce(events, acc, fn {event_name, func}, acc_ ->
            case Repo.get_by(Event,
                  service_id: trigger_service.id, name: event_name) do
              nil ->
                IO.puts "Event #{event_name} not found"
              event ->
                Map.put(acc_, event.id, {module, func})
            end
          end)
      end
    end)
  end
end
