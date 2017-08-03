defmodule Poselink.TriggerService.ButtonTrigger do
  use GenServer

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.Trigger
  alias Poselink.Event

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def on_click(_user, payload) do
    GenServer.cast(__MODULE__, {:on_click, payload})
  end

  def handle_cast({:on_click, payload}, service_id) do
    case payload do
      %{"combinationId" => combination_id} ->

        query =
          from t in Trigger,
          join: c in Combination,
          where: c.trigger_id == t.id and c.id == ^combination_id,
          join: e in Poselink.Event,
          where: e.id == t.event_id,
          select: t

        query
        |> Repo.all()
        |> Enum.each(fn trigger ->
          Poselink.TriggerServer.trigger(trigger, payload)
        end)
    end

    {:noreply, service_id}
  end
end
