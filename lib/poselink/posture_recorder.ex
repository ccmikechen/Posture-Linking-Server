defmodule Poselink.PostureRecorder do
  use GenServer

  alias Poselink.PostureRecorderServer

  def start_link(user_id, config) do
    state = %{
      user_id: user_id,
      config: config,
      data: []
    }
    {:ok, pid} = GenServer.start_link(__MODULE__, state)
    PostureRecorderServer.put_recorder(pid, user_id)

    {:ok, pid}
  end

  def push_data(user_id, data) do
    pid = PostureRecorderServer.get_recorder(user_id)
    GenServer.cast(pid, {:push_data, data})
  end

  def save(user_id) do
    pid = PostureRecorderServer.get_recorder(user_id)
    GenServer.cast(pid, :save)
    GenServer.stop(pid)
    PostureRecorderServer.delete_recorder(user_id)
  end

  def handle_cast({:push_data, data}, state) do
    new_state = %{state | data: [data | state.data]}
    IO.inspect data
    {:noreply, new_state}
  end

  def handle_cast(:save, state) do
    IO.inspect state
    {:noreply, nil}
  end
end
