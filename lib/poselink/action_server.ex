defmodule Poselink.ActionServer do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.Event
  alias Poselink.ActionService

  def start_link do
    action_events = load_action_events()

    GenServer.start_link(__MODULE__, action_events, [name: __MODULE__])
  end

  def execute(user, action, payload) do
    GenServer.cast(__MODULE__, {:execute, user, action, payload})
  end

  # Server

  def handle_cast({:execute, user, action, payload}, action_events) do
    event = Repo.get_by(Event, id: action.event_id)
    config = Poison.decode!(action.config)

    IO.puts "#{inspect(self())}: Service #{event.service_id} has been executed"

    {action, func} = action_events[event.id]
    apply(action, func, [user, payload, config])

    {:noreply, action_events}
  end

  defp load_action_events do
    [services: services] = Application.get_env(:poselink, ActionService)
    Enum.reduce(services, %{}, fn {service_name, module, events}, acc ->
      case Repo.get_by(Service, name: service_name) do
        nil ->
          IO.puts "Service #{service_name} not found"
          acc
        action_service ->
          Enum.reduce(events, acc, fn {event_name, func}, acc_ ->
            case Repo.get_by(Event,
                  service_id: action_service.id, name: event_name) do
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
