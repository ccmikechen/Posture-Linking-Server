defmodule Poselink.ActionServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def execute(user_id, action_id, payload) do
    GenServer.cast(__MODULE__, {:execute, user_id, action_id, payload})
  end

  # Server

  def handle_cast({:execute, user_id, action_id, payload}, state) do
    # get action by action_id and execute action
    user = Poselink.Repo.get(Poselink.User, user_id)
    IO.puts "#{inspect(self)}: Action #{action_id} has been executed by #{user.username}"
    {:noreply, state}
  end

end
