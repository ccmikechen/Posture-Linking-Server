defmodule Poselink.TriggerService.ButtonTrigger do
  use GenServer

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def trigger(_user, payload) do
    GenServer.cast(__MODULE__, {:trigger, payload})
  end

  def handle_cast({:trigger, payload}, service_id) do
    import Ecto.Query

    alias Poselink.Repo
    alias Poselink.Combination

    combination =
      Repo.get(Combination, payload["combination_id"])
      |> Repo.preload(:trigger)

    Poselink.TriggerServer.trigger(combination.trigger, payload)
    {:noreply, service_id}
  end

  
end
