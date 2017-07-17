defmodule Poselink.ActionService.SmartBolbAction do
  use GenServer

  alias Poselink.Repo

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def turn_on(user, payload, config) do
    GenServer.cast(__MODULE__, {:turn_on, user, payload, config})
  end

  def turn_off(user, payload, config) do
    GenServer.cast(__MODULE__, {:turn_off, user, payload, config})
  end

  def handle_cast({:turn_on, user, payload, config}, service_id) do
    # TODO: SmartBolbAction.turn_on()
    {:noreply, service_id}
  end

  def handle_cast({:turn_off, user, payload, config}, service_id) do
    # TODO: SmartBolbAction.turn_off()
    {:noreply, service_id}
  end
end
