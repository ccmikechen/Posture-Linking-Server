defmodule Poselink.TriggerService.PostureTrigger do
  use GenServer

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.Trigger
  alias Poselink.Event

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def on_stand(_user, payload) do
    GenServer.cast(__MODULE__, {:on_stand, payload})
  end

  def handle_cast({:on_stand, payload}, service_id) do
    
    {:noreply, service_id}
  end
end
