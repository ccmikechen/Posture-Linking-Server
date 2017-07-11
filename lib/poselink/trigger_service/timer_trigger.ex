defmodule Poselink.TriggerService.TimerTrigger do
  use GenServer

  alias Poselink.Repo
  alias Poselink.Trigger
  alias Poselink.Event

  @timer_gap 15000

  def start_link(service_id) do
    Poselink.AbsoluteTimer.start_link(@timer_gap, __MODULE__, :on_time)
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def on_time(time) do
    GenServer.cast(__MODULE__, {:on_time, time})
  end

  def handle_cast({:on_time, time}, service_id) do
    import Ecto.Query

    query =
      from t in Trigger,
      join: e in Event, on: [id: t.event_id],
      where: e.service_id == ^service_id and e.name == "on time",
      select: t

    query
    |> Repo.all()
    |> Enum.each(fn trigger ->
      case Poison.decode!(trigger.config) do
        %{"time" => ^time} ->
          Poselink.TriggerServer.trigger(trigger, %{})
      end
    end)

    {:noreply, service_id}
  end
end
