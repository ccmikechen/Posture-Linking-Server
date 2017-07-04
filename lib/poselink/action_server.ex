defmodule Poselink.ActionServer do
  use GenServer

  def start_link(action_services) do
    GenServer.start_link(__MODULE__, action_services, [name: __MODULE__])
  end

  def execute(user, action, payload) do
    GenServer.cast(__MODULE__, {:execute, user, action, payload})
  end

  # Server

  def handle_cast({:execute, user, action, payload}, action_services) do
    alias Poselink.Repo
    alias Poselink.Service

    service = Repo.get_by(Service, id: action.service_id)
    config = Poison.decode!(action.config)

    IO.puts "#{inspect(self)}: Service #{service.id} has been executed"

    action_service = action_services[service.id]
    action_service.execute(user, payload, config)

    {:noreply, action_services}
  end

end
