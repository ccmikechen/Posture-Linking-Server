defmodule Poselink.ActionServer do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Service
  alias Poselink.ActionService

  def start_link do
    action_services = load_action_services()

    GenServer.start_link(__MODULE__, action_services, [name: __MODULE__])
  end

  def execute(user, action, payload) do
    GenServer.cast(__MODULE__, {:execute, user, action, payload})
  end

  # Server

  def handle_cast({:execute, user, action, payload}, action_services) do
    service = Repo.get_by(Service, id: action.service_id)
    config = Poison.decode!(action.config)

    IO.puts "#{inspect(self)}: Service #{service.id} has been executed"

    action_service = action_services[service.id]
    action_service.execute(user, payload, config)

    {:noreply, action_services}
  end

  defp load_action_services do
    [services: services] = Application.get_env(:poselink, ActionService)
    Enum.reduce(services, %{}, fn {name, module}, acc ->
      action_service = Repo.get_by(Service, name: name)
      Map.put(acc, action_service.id, module)
    end)
  end
end
