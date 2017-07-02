defmodule Poselink.TriggerServer do
  use GenServer
  
  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.Trigger

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def trigger(user_id, service_id, payload) do
    GenServer.cast(__MODULE__, {:trigger, user_id, service_id, payload})
  end

  # Server

  def handle_cast({:trigger, user_id, service_id, payload}, state) do
    # get combinations which will be actioned by user_id and
    # trigger_id, then cast action with action_id
    import Ecto.Query

    query =
      from c in Combination,
      join: t in Trigger, on: [id: c.trigger_id],
      where: c.user_id == ^user_id and t.service_id == ^service_id,
      select: c

    combinations = Repo.all(query)
    combinations
    |> Enum.each(fn combination ->
      if combination.status == 1 do
        IO.puts "#{inspect(self)}: Combination #{combination.id} has been triggered"
        Poselink.ActionServer.execute(user_id, combination.action_id, payload)
      end
    end)

    {:noreply, state}
  end

end
