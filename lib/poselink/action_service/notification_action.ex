defmodule Poselink.ActionService.NotificationAction do
  use GenServer

  alias Poselink.Repo
  alias Poselink.UserServiceConfig

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def execute(user, payload, config) do
    GenServer.cast(__MODULE__, {:execute, user, payload, config})
  end

  def handle_cast({:execute, user, payload, config}, service_id) do
    [api_key: key] = Application.get_env(:poselink, __MODULE__)
    
    %{"gcm" => %{"token" => token}} =
      UserServiceConfig
      |> Repo.get_by!(user_id: user.id, service_id: service_id)
      |> Map.get(:config)
      |> Poison.decode!
    %{"content" => message} = config

    send_notification(key, token, message)

    {:noreply, service_id}
  end

  defp send_notification(key, token, message) do
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
