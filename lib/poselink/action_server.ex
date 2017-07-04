defmodule Poselink.ActionServer do
  use GenServer

  alias Poselink.ActionService

  @action_services %{
    2 => ActionService.NotificationAction
  }

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def execute(action, payload) do
    GenServer.cast(__MODULE__, {:execute, action, payload})
  end

  # Server

  def handle_cast({:execute, action, payload}, state) do
    alias Poselink.Repo
    alias Poselink.User
    alias Poselink.Service

    service = Repo.get_by(Service, id: action.service_id)

    IO.puts "#{inspect(self)}: Service #{service.id} has been executed"

    action_service = @action_services[service.id]
    action_service.execute(payload, action.config)

    {:noreply, state}
  end

end
