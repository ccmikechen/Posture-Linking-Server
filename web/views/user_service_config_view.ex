defmodule Poselink.UserServiceConfigView do
  use Poselink.Web, :view

  def render("index.json", %{user_service_configs: user_service_configs}) do
    %{data: render_many(user_service_configs, Poselink.UserServiceConfigView, "user_service_config.json")}
  end

  def render("show.json", %{user_service_config: user_service_config}) do
    %{data: render_one(user_service_config, Poselink.UserServiceConfigView, "user_service_config.json")}
  end

  def render("user_service_config.json", %{user_service_config: user_service_config}) do
    %{
      id: user_service_config.id,
      config: Poison.decode!(user_service_config.config),
      status: user_service_config.status,
      service_id: user_service_config.service_id
    }
  end
end
