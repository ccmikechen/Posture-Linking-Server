defmodule Poselink.ActionService.NotificationAction do
  use GenServer

  alias Poselink.Repo
  alias Poselink.UserServiceConfig

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def do_notification(user, payload, config) do
    GenServer.cast(__MODULE__, {:do_notification, user, payload, config})
  end

  def handle_cast({:do_notification, user, payload, config}, service_id) do
    [api_key: key] = Application.get_env(:poselink, __MODULE__)

    %{"gcm" => %{"token" => token}} =
      UserServiceConfig
      |> Repo.get_by!(user_id: user.id, service_id: service_id)
      |> Map.get(:config)
      |> Poison.decode!
    %{"message" => message} = config

    message
    |> Poselink.ActionService.combine_message_and_payload(payload)
    |> send_notification(key, token)

    {:noreply, service_id}
  end

  defp send_notification(message, key, token) do
    GCM.push(key, [token],
      %{notification: %{
           title: "Posture Linking",
           body: message,
           message: message,
           sound: "default",
           icon: "default",
           color: "#FFFFFF"
        },
        data: %{
          message: message
        }
      }
    )
  end

end
