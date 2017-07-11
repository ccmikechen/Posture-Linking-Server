defmodule Poselink.EventView do
  use Poselink.Web, :view

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      name: event.name,
      description: event.description,
      options: Poison.decode!(event.options)
    }
  end
end
