defmodule Poselink.CombinationView do
  use Poselink.Web, :view

  alias Poselink.Repo

  def render("index.json", %{combinations: combinations}) do
    %{data: render_many(combinations, Poselink.CombinationView, "combination.json")}
  end

  def render("show.json", %{combination: combination}) do
    %{data: render_one(combination, Poselink.CombinationView, "combination.json")}
  end

  def render("combination.json", %{combination: combination}) do
    trigger = Repo.preload(combination.trigger, :event)
    action = Repo.preload(combination.action, :event)

    %{
      id: combination.id,
      trigger: %{
        event_id: trigger.event.id,
        service_id: trigger.event.service_id,
        config: Poison.decode!(combination.trigger.config)
      },
      action: %{
        event_id: action.event.id,
        service_id: action.event.service_id,
        config: Poison.decode!(combination.action.config)
      },
      description: combination.description,
      status: combination.status
    }
  end
end
