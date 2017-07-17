defmodule Poselink.ActionService.SheetMusicTurnerAction do
  use GenServer

  alias Poselink.Repo

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def turn_next(user, payload, config) do
    GenServer.cast(__MODULE__, {:turn_next, user, payload, config})
  end

  def turn_back(user, payload, config) do
    GenServer.cast(__MODULE__, {:turn_back, user, payload, config})
  end

  def go_first(user, payload, config) do
    GenServer.cast(__MODULE__, {:go_first, user, payload, config})
  end

  def handle_cast({:turn_next, user, payload, config}, service_id) do
    # TODO: SheetMusicTurnerAction.turn_next()
    {:noreply, service_id}
  end

  def handle_cast({:turn_back, user, payload, config}, service_id) do
    # TODO: SheetMusicTurnerAction.turn_back()
    {:noreply, service_id}
  end

  def handle_cast({:go_first, user, payload, config}, service_id) do
    # TODO: SheetMusicTurnerAction.go_first()
    {:noreply, service_id}
  end
end
