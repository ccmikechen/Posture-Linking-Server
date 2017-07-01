defmodule Poselink.ActionServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def action(user_id, action_id, payload) do
    GenServer.cast(__MODULE__, {:action, user_id, action_id, payload})
  end

  # Server

  def handle_cast({:action, user_id, action_id, payload}, state) do
    # get action by action_id and execute action

    {:noreply, state}
  end

end
