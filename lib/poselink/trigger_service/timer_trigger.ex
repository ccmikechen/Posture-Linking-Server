defmodule Poselink.TriggerService.TimerTrigger do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Trigger

  @timer_gap 10000

  def start_link(service_id) do
    Poselink.AbsoluteTimer.start_link(@timer_gap, __MODULE__, :trigger)
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def trigger do
    GenServer.cast(__MODULE__, {:trigger})
  end

  def handle_cast({:trigger}, service_id) do
    import Ecto.Query

    query = from t in Trigger, where: t.service_id == ^service_id
    query
    |> Repo.all()
    |> Enum.each(fn trigger ->
      Poselink.TriggerServer.trigger(trigger, %{})
    end)

    {:noreply, service_id}
  end
end
