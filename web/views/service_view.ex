defmodule Poselink.ServiceView do
  use Poselink.Web, :view

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Event

  @types %{
    1 => "trigger",
    2 => "action"
  }

  def render("index.json", %{services: services}) do
    %{data: render_many(services, Poselink.ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    type = @types[service.type]
    event_query =
      from e in Event, where: e.service_id == ^service.id
    events = Repo.all(event_query)

    %{
      id: service.id,
      name: service.name,
      icon: service.icon,
      type: type,
      classification: service.classification.name,
      events: render_many(events, Poselink.EventView, "event.json")
    }
  end
end
