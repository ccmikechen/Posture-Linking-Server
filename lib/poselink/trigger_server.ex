defmodule Poselink.TriggerServer do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.Trigger

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def trigger(trigger, payload) do
    GenServer.cast(__MODULE__, {:trigger, trigger, payload})
  end

  # Server

  def handle_cast({:trigger, trigger, payload}, state) do
    import Ecto.Query

    query =
      from c in Combination,
      preload: [:action],
      where: c.trigger_id == ^trigger.id

    combinations = Repo.all(query)
    combinations
    |> Enum.each(fn combination ->
      if combination.status == 1 do
        IO.puts "#{inspect(self)}: Combination #{combination.id} has been triggered"
        Poselink.ActionServer.execute(combination.action, payload)
      end
    end)

    {:noreply, state}
  end

end
