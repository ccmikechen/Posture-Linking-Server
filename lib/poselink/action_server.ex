defmodule Poselink.ActionServer do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.Event
  alias Poselink.ActionService
  alias Poselink.UserServiceConfig

  def start_link do
    action_events = load_action_events()

    GenServer.start_link(__MODULE__, action_events, [name: __MODULE__])
  end

  def execute(user, action, payload) do
    GenServer.cast(__MODULE__, {:execute, user, action, payload})
  end

  # Server

  def handle_cast({:execute, user, action, payload}, action_events) do
    event = Repo.get(Event, action.event_id)

    case check_service_status(event.service_id) do
      {:connected, _} ->
        config = Poison.decode!(action.config)

        IO.puts "#{inspect(self())}: Service #{event.service_id} has been executed"

        {action, func} = action_events[event.id]
        apply(action, func, [user, payload, config])
      {:not_connected, _} ->
        :nothing
    end

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


  defp check_service_status(service_id) do
    config = Repo.get_by(UserServiceConfig, service_id: service_id)

    case config.status do
      "connected" ->
        {:connected, config}
      _ ->
        {:not_connected, config}
    end
  end
end
