defmodule Poselink.CombinationView do
  use Poselink.Web, :view

  def render("index.json", %{combinations: combinations}) do
    %{data: render_many(combinations, Poselink.CombinationView, "combination.json")}
  end

  def render("show.json", %{combination: combination}) do
    %{data: render_one(combination, Poselink.CombinationView, "combination.json")}
  end

  def render("combination.json", %{combination: combination}) do
    %{id: combination.id,
      user_id: combination.user_id,
      trigger_id: combination.trigger_id,
      action_id: combination.action_id,
      description: combination.description,
      status: combination.status}
  end
end
