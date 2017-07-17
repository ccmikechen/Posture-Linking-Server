defmodule Poselink.ActionService.CameraAction do
  use GenServer

  alias Poselink.Repo

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def do_capturing(user, payload, config) do
    GenServer.cast(__MODULE__, {:do_capturing, user, payload, config})
  end

  def handle_cast({:do_capturing, user, payload, config}, service_id) do
    # TODO: CameraAction.do_capturing()
    {:noreply, service_id}
  end
end
