defmodule Poselink.ActionServer do
  use GenServer

  alias Poselink.ActionService

  @action_services %{
    2 => ActionService.NotificationAction
  }

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def execute(user_id, action_id, payload) do
    GenServer.cast(__MODULE__, {:execute, user_id, action_id, payload})
  end

  # Server

  def handle_cast({:execute, user_id, action_id, payload}, state) do
    alias Poselink.Repo
    alias Poselink.User
    alias Poselink.Action
    
    user = Repo.get(User, user_id)
    service_id = Repo.get(Action, action_id).service_id

    IO.puts "#{inspect(self)}: Service #{service_id} has been executed by #{user.username}"

    service = @action_services[service_id]
    service.execute(user, payload)

    {:noreply, state}
  end

end
