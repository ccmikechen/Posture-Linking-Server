defmodule Poselink.PingView do
  use Poselink.Web, :view

  def render("show.json", _params) do
    %{
      result: "ok"
    }
  end
end
