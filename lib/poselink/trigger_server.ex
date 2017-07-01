defmodule Poselink.TriggerServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def trigger(user_id, service_id, payload) do
    GenServer.cast(__MODULE__, {:trigger, user_id, service_id})
  end

  # Server

  def handle_cast({:trigger, user_id, service_id, payload}, state) do
    # get combinations which will be actioned by user_id and
    # trigger_id, then cast action with action_id

    {:noreply, state}
  end

end
