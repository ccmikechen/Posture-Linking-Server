defmodule Poselink.CombinationView do
  use Poselink.Web, :view

  def render("index.json", %{combinations: combinations}) do
    %{data: render_many(combinations, Poselink.CombinationView, "combination.json")}
  end

  def render("combination.json", %{combination: combination}) do
    %{
      id: combination.id,
      trigger: %{
        service_id: combination.trigger.service_id,
        config: Poison.decode!(combination.trigger.config)
      },
      action: %{
        service_id: combination.action.service_id,
        config: Poison.decode!(combination.action.config)
      },
      description: combination.description,
      status: combination.status
    }
  end
end
