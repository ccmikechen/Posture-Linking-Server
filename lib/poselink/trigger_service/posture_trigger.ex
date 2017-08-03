defmodule Poselink.TriggerService.PostureTrigger do
  use GenServer

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.Trigger
  alias Poselink.Event

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def on_action(_user, payload) do
    GenServer.cast(__MODULE__, {:on_action, payload})
  end

  def handle_cast({:on_action, payload}, service_id) do
    import Ecto.Query

    posture_id = payload["postureId"]

    query =
      from t in Trigger,
      join: e in Event, on: [id: t.event_id],
      where: e.service_id == ^service_id and e.name == "on action",
      select: t

    query
    |> Repo.all()
    |> Enum.each(fn trigger ->
      case Poison.decode!(trigger.config) do
        %{"posture_id" => ^posture_id} ->
          Poselink.TriggerServer.trigger(trigger, %{})
        _ ->
          :nothing
      end
    end)

    {:noreply, service_id}
  end
end
