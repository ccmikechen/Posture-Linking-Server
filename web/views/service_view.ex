defmodule Poselink.ServiceView do
  use Poselink.Web, :view

  @types %{
    1 => "trigger",
    2 => "action"
  }

  def render("index.json", %{services: services}) do
    %{data: render_many(services, Poselink.ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    type = @types[service.type]

    %{
      id: service.id,
      name: service.name,
      icon: service.icon,
      type: type,
      classification: service.classification.name
    }
  end
end
