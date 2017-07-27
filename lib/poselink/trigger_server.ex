defmodule Poselink.TriggerServer do
  use GenServer

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.UserServiceConfig
  alias Poselink.Event

  def start_link do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def trigger(trigger, payload) do
    GenServer.cast(__MODULE__, {:trigger, trigger, payload})
  end

  # Server

  def handle_cast({:trigger, trigger, payload}, state) do
    event = Repo.get(Event, trigger.event_id)
    query =
      from c in Combination,
      preload: [:action, :user],
      where: c.trigger_id == ^trigger.id

    combinations = Repo.all(query)

    combinations
    |> Enum.each(fn combination ->
      if combination.status == 1 do
        case check_service_status(event.service_id) do
          {:connected, _} ->
            IO.puts "#{inspect(self())}: Combination #{combination.id} has been triggered"
            Poselink.ActionServer.execute(
              combination.user,
              combination.action,
              payload
            )
          {:not_connected, _} ->
            :nothing
        end
      end
    end)

    {:noreply, state}
  end

  defp check_service_status(service_id) do
    config = Repo.get_by(UserServiceConfig, service_id: service_id)

    case config.status do
      "connected" ->
        {:connected, config}
      _ ->
        {:not_connected, config}
    end
  end
end
