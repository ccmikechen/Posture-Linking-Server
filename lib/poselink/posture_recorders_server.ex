defmodule Poselink.PostureRecordersServer do

  def start_link do
    Agent.start_link(__MODULE__, :init, [], name: __MODULE__)
  end

  def init do
    Map.new
  end

  def put_recorder(pid, user_id) do
    Agent.update(__MODULE__, &Map.put(&1, user_id, pid))
  end

  def get_recorder(user_id) do
    Agent.get(__MODULE__, &Map.get(&1, user_id))
  end

  def delete_recorder(user_id) do
    Agent.update(__MODULE__, &Map.delete(&1, user_id))
  end
end
