defmodule Poselink.TriggerService.LineMessagingTrigger do
  use GenServer

  import Ecto.Query

  alias Poselink.Repo
  alias Poselink.Combination
  alias Poselink.UserServiceConfig

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def handle_event(event) do
    GenServer.cast(__MODULE__, {:event, event})
  end

  def trigger(user, payload) do
    GenServer.cast(__MODULE__, {:trigger, payload})
  end

  def handle_cast({:event,
                   %{"type" => "message",
                     "source" => %{
                       "userId" => line_user_id
                     },
                     "message" => %{
                       "text" => text,
                       "type" => "text"
                     },
                     "replyToken" => reply_token
                   }}, service_id) do
    get_user_by_line_user_id(line_user_id, service_id)
    |> Enum.each(fn user ->
      payload = %{"message" => text, "reply_token" => reply_token}
      query =
        from t in Trigger,
      where: t.user_id == ^user.id and t.service_id == ^service_id
      query
      |> Repo.all()
      |> Poselink.TriggerServer.trigger(payload)
    end)

    {:noreply, service_id}
  end

  def handle_cast({:event, event = %{"type" => "beacon"}, user}, service_id) do
    {:noreply, service_id}
  end

  def handle_cast({:trigger, payload}, service_id) do
    combination =
      Repo.get(Combination, payload["combination_id"])
      |> Repo.preload(:trigger)

    Poselink.TriggerServer.trigger(combination.trigger, payload)
    {:noreply, service_id}
  end

  defp get_user_by_line_user_id(line_user_id, service_id) do
    query =
      from c in UserServiceConfig,
      where: c.service_id == ^service_id,
      preload: [:user]

    Repo.all(query)
    |> Enum.filter(fn usc ->
      case usc do
        %{"config" => config} ->
          case Poison.decode!(config) do
            %{"line_messaging" => %{"user_id" => line_user_id}} ->
              true
            _ ->
              false
          end
        _ ->
          false
      end
    end)
    |> Enum.map(fn %{"user" => user} -> user end)
  end
end
