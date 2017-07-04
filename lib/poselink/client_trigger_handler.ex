defmodule Poselink.ClientTriggerHandler do
  use GenServer

  alias Poselink.ActionService

  def start_link(trigger_services) do
    GenServer.start_link(__MODULE__, trigger_services, [name: __MODULE__])
  end

  def handle_trigger(user, service_id, payload) do
    GenServer.cast(__MODULE__, {:handle_trigger, user, service_id, payload})
  end

  def handle_cast({:handle_trigger, user, service_id, payload}, trigger_services) do
    alias Poselink.Repo
    alias Poselink.User
    alias Poselink.Service

    service = trigger_services[service_id]
    service.trigger(user, payload)

    {:noreply, trigger_services}
  end

end
